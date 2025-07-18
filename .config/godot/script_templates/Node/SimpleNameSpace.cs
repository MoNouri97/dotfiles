using GDHelpers;
using Godot;

public partial class _CLASS_ : _BASE_
{
    public override void _Ready() { }

    public override void _Process(double delta) { }

    public override void _Notification(int what)
    {
        if (what == NotificationEnterTree)
        {
            this.WireOnReady();
        }
    }
}
