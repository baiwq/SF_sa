global class FileServerMethod{
   webservice static string ext(){
      FileServerToken.TokenServiceSoap TT = new FileServerToken.TokenServiceSoap();
      String ds = TT.GetToken('SOSP','SOSPabcd-1234');
      System.debug('ds--'+ds);
      return ds;
   }
}