// SignalR Hub for Team Chat
// Add this to your ASP.NET Core backend project

using Microsoft.AspNetCore.SignalR;
using System.Collections.Concurrent;

namespace AnkhAPI.Hubs
{
    public class TeamChatHub : Hub
    {
        private static readonly ConcurrentDictionary<string, string> _userConnections = new();
        private static readonly ConcurrentDictionary<string, List<string>> _teamRooms = new();

        public override async Task OnConnectedAsync()
        {
            var userId = GetUserIdFromToken();
            if (!string.IsNullOrEmpty(userId))
            {
                _userConnections[userId] = Context.ConnectionId;
                await Clients.Caller.SendAsync("ReceiveSystemMessage", $"تم الاتصال بنجاح. معرف المستخدم: {userId}");
            }
            await base.OnConnectedAsync();
        }

        public override async Task OnDisconnectedAsync(Exception? exception)
        {
            var userId = GetUserIdFromToken();
            if (!string.IsNullOrEmpty(userId))
            {
                _userConnections.TryRemove(userId, out _);
                await LeaveAllTeams(userId);
            }
            await base.OnDisconnectedAsync(exception);
        }

        public async Task JoinTeamRoom(string teamId)
        {
            var userId = GetUserIdFromToken();
            if (string.IsNullOrEmpty(userId)) return;

            if (!_teamRooms.ContainsKey(teamId))
            {
                _teamRooms[teamId] = new List<string>();
            }

            if (!_teamRooms[teamId].Contains(userId))
            {
                _teamRooms[teamId].Add(userId);
            }

            await Groups.AddToGroupAsync(Context.ConnectionId, teamId);
            await Clients.Group(teamId).SendAsync("ReceiveSystemMessage", $"انضم {GetUserName(userId)} إلى الفريق");
            
            // Load recent messages (you can implement this with your database)
            await LoadRecentMessages(teamId);
        }

        public async Task LeaveTeamRoom(string teamId)
        {
            var userId = GetUserIdFromToken();
            if (string.IsNullOrEmpty(userId)) return;

            if (_teamRooms.ContainsKey(teamId))
            {
                _teamRooms[teamId].Remove(userId);
            }

            await Groups.RemoveFromGroupAsync(Context.ConnectionId, teamId);
            await Clients.Group(teamId).SendAsync("ReceiveSystemMessage", $"غادر {GetUserName(userId)} الفريق");
        }

        public async Task SendMessageToTeam(string teamId, string message)
        {
            var userId = GetUserIdFromToken();
            if (string.IsNullOrEmpty(userId)) return;

            var messageData = new
            {
                senderId = userId,
                senderName = GetUserName(userId),
                message = message,
                sentAt = DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
            };

            await Clients.Group(teamId).SendAsync("ReceiveMessage", messageData);
            
            // Save message to database (implement this)
            await SaveMessageToDatabase(teamId, userId, message);
        }

        private async Task LoadRecentMessages(string teamId)
        {
            // Implement this to load recent messages from your database
            // For now, we'll send a system message
            await Clients.Caller.SendAsync("LoadRecentMessages", new List<object>());
        }

        private async Task SaveMessageToDatabase(string teamId, string userId, string message)
        {
            // Implement this to save messages to your database
            // Example: await _chatService.SaveMessageAsync(teamId, userId, message);
        }

        private async Task LeaveAllTeams(string userId)
        {
            foreach (var team in _teamRooms)
            {
                if (team.Value.Contains(userId))
                {
                    await Groups.RemoveFromGroupAsync(Context.ConnectionId, team.Key);
                }
            }
        }

        private string GetUserIdFromToken()
        {
            // Extract user ID from JWT token
            // This depends on your JWT configuration
            var user = Context.User;
            return user?.FindFirst("http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")?.Value ?? "";
        }

        private string GetUserName(string userId)
        {
            // Get user name from your user service/database
            // For now, return a generic name
            return "عضو الفريق";
        }
    }
}

// Program.cs or Startup.cs configuration:
/*
public void ConfigureServices(IServiceCollection services)
{
    // ... other services
    
    services.AddSignalR();
    
    // Configure CORS for SignalR
    services.AddCors(options =>
    {
        options.AddPolicy("SignalRPolicy", policy =>
        {
            policy.WithOrigins("https://ankhapi.runasp.net")
                  .AllowAnyHeader()
                  .AllowAnyMethod()
                  .AllowCredentials();
        });
    });
}

public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    // ... other middleware
    
    app.UseCors("SignalRPolicy");
    app.UseRouting();
    app.UseAuthentication();
    app.UseAuthorization();
    
    app.UseEndpoints(endpoints =>
    {
        // ... other endpoints
        
        endpoints.MapHub<TeamChatHub>("/hubs/teamchat");
    });
}
*/ 