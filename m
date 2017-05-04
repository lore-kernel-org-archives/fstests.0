Received: from mx1.redhat.com ([209.132.183.28]:44920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753203AbdEDRNS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 May 2017 13:13:18 -0400
Subject: Re: [PATCH] punch-alternating: add some options
References: <ad311156-c99a-4269-051e-082b259bb0de@redhat.com>
 <20170504154916.GB5970@birch.djwong.org>
From: Eric Sandeen <sandeen@redhat.com>
Message-ID: <cd112829-8274-4924-8671-e9465914111c@redhat.com>
Date: Thu, 4 May 2017 12:13:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170504154916.GB5970@birch.djwong.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 5/4/17 10:49 AM, Darrick J. Wong wrote:
> On Thu, May 04, 2017 at 10:16:54AM -0500, Eric Sandeen wrote:
>> I didn't end up using this, but somebody else might find
>> it useful, so sending it.
>>
>> This change lets us specify punch patterns other than
>> literally every other block.
>>
>> i.e. punch-alternating with no options will do:
>>
>> ...HDHDHDHDHDHD...
>>
>> -i 4 -s 2 will do:
>>
>> ...DDHHDDHHDDHH...
>>
>> or -i 3 -s 1 will do:
>>
>> ...DDHDDHDDHDDH...
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/src/punch-alternating.c b/src/punch-alternating.c
>> index 4148622..0c7a7ff 100644
>> --- a/src/punch-alternating.c
>> +++ b/src/punch-alternating.c
>> @@ -11,6 +11,14 @@
>>  #include <string.h>
>>  #include "global.h"
>>  
>> +void usage(char *cmd)
>> +{
>> +	printf("Usage: %s [-i interval] [-s size] file\n", cmd);
>> +	printf("Punches every other block in the file by default,\n");
>> +	printf("or 'size' blocks every 'interval' blocks with options.\n");
>> +	exit(1);
>> +}
>> +
>>  int main(int argc, char *argv[])
>>  {
>>  	struct stat	s;
>> @@ -21,14 +29,27 @@ int main(int argc, char *argv[])
>>  	off_t		sz;
>>  	int		mode;
>>  	int		error;
>> +	int		c;
>> +	int		size = 1;	/* punch $SIZE blocks ... */
>> +	int		interval = 2;	/* every $INTERVAL blocks */
>> +
>> +	if (argc < 2)
>> +		usage(argv[0]);
> 
> I think you want a (optind == argc - 1) check after the getopt to
> preserve the "only one file at a time" semantics... or an optind loop to
> process a bunch of files.

Hm, ok.  getopt is not my favorite.

>> -	if (argc != 2) {
>> -		printf("Usage: %s file\n", argv[0]);
>> -		printf("Punches every other block in the file.\n");
>> -		return 1;
>> +	while ((c = getopt(argc, argv, "i:s:")) != EOF) {
>> +		switch (c) {
>> +		case 'i':
>> +			interval = atoi(optarg);
>> +			break;
>> +		case 's':
>> +			size = atoi(optarg);
>> +			break;
>> +		default:
>> +			usage(argv[0]);
>> +		}
>>  	}
> 
> Is it valid to -i 0 -s -5 here? :)

Sure!  you'll just have to ctrl-C it.  ;)

-Eric
 
> --D
> 
>> -	fd = open(argv[1], O_WRONLY);
>> +	fd = open(argv[optind], O_WRONLY);
>>  	if (fd < 0)
>>  		goto err;
>>  
>> @@ -44,8 +65,8 @@ int main(int argc, char *argv[])
>>  	blksz = sf.f_bsize;
>>  
>>  	mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
>> -	for (offset = 0; offset < sz; offset += blksz * 2) {
>> -		error = fallocate(fd, mode, offset, blksz);
>> +	for (offset = 0; offset < sz; offset += blksz * interval) {
>> +		error = fallocate(fd, mode, offset, blksz * size);
>>  		if (error)
>>  			goto err;
>>  	}
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

