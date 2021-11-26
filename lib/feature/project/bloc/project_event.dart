abstract class ProjectEvent{}

class ProjectGetEvent extends ProjectEvent{
  String staffId;
  ProjectGetEvent(this.staffId);
}