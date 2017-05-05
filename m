Received: from sandeen.net ([63.231.237.45]:35484 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbdEENTZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 May 2017 09:19:25 -0400
Subject: Re: [PATCH V3] punch-alternating: add some options
References: <ad311156-c99a-4269-051e-082b259bb0de@redhat.com>
 <1a55a8a0-00dd-bb73-c888-5c1a889c7302@sandeen.net>
 <0768eacb-b76f-3a4b-e05a-bc39dde343b4@sandeen.net>
 <20170505043234.GQ7250@eguan.usersys.redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <313bd3ed-8760-c7ee-3a7f-85daa79b510c@sandeen.net>
Date: Fri, 5 May 2017 08:19:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170505043234.GQ7250@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>


On 5/4/17 11:32 PM, Eryu Guan wrote:
> On Thu, May 04, 2017 at 01:25:05PM -0500, Eric Sandeen wrote:

...

>> -	if (argc != 2) {
>> -		printf("Usage: %s file\n", argv[0]);
>> -		printf("Punches every other block in the file.\n");
>> -		return 1;
>> +	if (size < 0) {
>> +		printf("size must be >= 0\n");
>> +		usage(argv[0]);
> 
> Can size be 0? Seems not, otherwise we call fallocate with zero length.
> I got this error if I use "-s 0"
> 
> $ ./src/punch-alternating -s 0 -i 8 testfile
> -s: Invalid argument
> 
> And the "-s" part indicates that the perror call in 'err' label should
> be updated too, i.e. argv[1] => argv[optind]
> 
> They're simple enough to be fixed at commit time, if you think they're
> sane fixes :)

Sigh, yes please.  I'm apparently now unable to write or test the simplest
code.  :/

-Eric
