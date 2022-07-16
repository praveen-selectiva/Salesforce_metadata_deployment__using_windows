trigger mapCheck on Account (before insert) {
	system.debug(Trigger.new);
}