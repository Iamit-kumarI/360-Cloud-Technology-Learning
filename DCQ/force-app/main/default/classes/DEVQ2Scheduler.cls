global class DEVQ2Scheduler {
	 global static void scheduleDEV2Q2OneClassForAll(){
        String croneTime='0 0 1 * * ?';
        System.schedule('DEV2Q2OneClassForAllR Scheduled',croneTime,new DEV2Q2OneClassForAllR());
    }
}