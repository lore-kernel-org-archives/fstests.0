Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:21293 "EHLO
	mx0a-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754618AbaJGSSg (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 7 Oct 2014 14:18:36 -0400
Received: from pps.filterd (m0075555.ppops.net [127.0.0.1])
	by mx0a-00003501.pphosted.com (8.14.5/8.14.5) with SMTP id s97I4sgV014955
	for <fstests@vger.kernel.org>; Tue, 7 Oct 2014 14:18:36 -0400
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com [209.85.216.51])
	by mx0a-00003501.pphosted.com with ESMTP id 1pvkx10e81-1
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Tue, 07 Oct 2014 14:18:35 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so4666015qaq.10
        for <fstests@vger.kernel.org>; Tue, 07 Oct 2014 11:18:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20141006232114.GK2301@dastard>
References: <1412619830-23088-1-git-send-email-paul.paulson@seagate.com>
	<20141006232114.GK2301@dastard>
Date: Tue, 7 Oct 2014 13:18:34 -0500
Message-ID: <CAG4SSaQg_2kZZsHUcO=q4m-P1CsD+ThyPcE58js+3sVWPymYAw@mail.gmail.com>
Subject: Re: [PATCH] generic/017: skip tests with mkfs failures
From: Paul Paulson <paul.paulson@seagate.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

>> diff --git a/tests/generic/017 b/tests/generic/017
>> index 13b7254..eb38d4d 100755
>> --- a/tests/generic/017
>> +++ b/tests/generic/017
>> @@ -49,8 +49,16 @@ _do_die_on_error=y
>>  testfile=$SCRATCH_MNT/$seq.$$
>>  BLOCKS=10240
>>
>> -for (( BSIZE = 1024; BSIZE <= 4096; BSIZE *= 2 )); do
>> +MAX_INODE_COUNT_1K=127877120
>> +inode_count=`$TUNE2FS_PROG -l $SCRATCH_DEV | awk '/Inode count:/ { print $3 }'`
>> +initial_bsize=$(($inode_count <= $MAX_INODE_COUNT_1K ? 1024 : 2048))
>
> FWIW, that'll break every filesystem type other than ext4.
Yes, that was an oversight on my part. The initial_bsize calculation
should have taken filesystem type into account.
