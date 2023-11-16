Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="F85lZgKf"
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 11:00:54 PST
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB336181
	for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 11:00:54 -0800 (PST)
Received: from [10.0.0.71] (liberator.sandeen.net [10.0.0.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id F18EE7905;
	Thu, 16 Nov 2023 12:53:34 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net F18EE7905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1700160815;
	bh=Bll5EVtak0xdJ9+cFvwgdRxqcAl1PuPU3XngECst/1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F85lZgKf39DzosCB2EON1kRW3ybCPdjJDgwDBNe3wy+bYwwRrkbRHCvCslrg8Wgh7
	 1jZ6d24UGn5GeYsguY7jNw2wAy5NLgZ4CA+0cw21qKfCBGlhQI6T7oXPboxRjJDmYe
	 RXPsukXNhEN96k/inQyKfGc7gLFSyX/3+FH2861kjLFNZTFYEGggedpt1KjjSFIBMj
	 W/4y1+7+xuYxruJJ+wAKgNVs5RS3pnSOZvqN+7iiYA/ms6PMkKhwg8h5FNcJkQ+sH1
	 3gGuvW6bPEJCwxVfk70/9Wy3RUfkvq9cWfJo7tVbq2UN8yjSv/OOGYPqdUFu1BfQeD
	 CL1hjwMvetZ9A==
Message-ID: <678a8d0a-1998-4b66-98c4-56a2e4ca0e28@sandeen.net>
Date: Thu, 16 Nov 2023 12:53:34 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfs/263: increase data section size to 1024M
Content-Language: en-US
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>,
 Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <20231115055659.2027-1-xuyang2018.jy@fujitsu.com>
 <20231115160543.GD36175@frogsfrogsfrogs>
 <20231116023341.4be2u2dtpghe5tan@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <OS7PR01MB1183929872AD5D43F1D7724D7FDB0A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <OS7PR01MB1183929872AD5D43F1D7724D7FDB0A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/16/23 1:05 AM, Yang Xu (Fujitsu) wrote:
> Hi Zorro
> 
>> As we've filter out the inode number, so the "inode numbers control" doesn't make sense anymore. It's fine for me to remove the "-d size=xxx" part (if it's still test passed).
> I have tested and pass. Will send a v2.
> 
> Best Regards
> Yang Xu
> 
> -----Original Message-----
> From: Zorro Lang <zlang@redhat.com> 
> Sent: Thursday, November 16, 2023 10:34 AM
> To: Xu, Yang/徐 杨 <xuyang2018.jy@fujitsu.com>
> Cc: Darrick J. Wong <djwong@kernel.org>; fstests@vger.kernel.org
> Subject: Re: [PATCH] xfs/263: increase data section size to 1024M
> 
> On Wed, Nov 15, 2023 at 08:05:43AM -0800, Darrick J. Wong wrote:
>> On Wed, Nov 15, 2023 at 12:56:59AM -0500, Yang Xu wrote:
>>> On machine with using raid, this case will trigger the following 
>>> error:
>>> ==== NO CRC ====
>>> +mkfs.xfs: small data volume, ignoring data volume stripe unit 512 
>>> +and stripe width 512
>>> == Options: rw ==
>>> == Options: usrquota,rw ==
>>>
>>> mkfs.xfs generates this error since xfsprogs commit 42371fb36
>>> ("mkfs: ignore data blockdev stripe geometry for small filesystems").
>>> It disables automatic detection of stripe unit and width if the data 
>>> device is less than 1GB.
>>>
>>> To slove false poistive, just increase data section size to 1G.
>>
>> Is there a particular reason why this test needs -d size= at all?
>>
>> There's a single comment about "Control size to control inode numbers"
>> but then filter_quota_state() seds the inode numbers to #XXX.  So 
>> perhaps that part of the mkfs argument isn't necessary anymore?
> 
> As we've filter out the inode number, so the "inode numbers control" doesn't make sense anymore. It's fine for me to remove the "-d size=xxx" part (if it's still test passed).

Sorry for the late reply, but I agree that it's not needed now.

(I wonder if we should just filter the "small data volume, ignoring data volume
stripe" message in a common filter, but we don't need to tie up this fix, I
think it's fine to change the size for this test.)

Thanks,
-Eric
