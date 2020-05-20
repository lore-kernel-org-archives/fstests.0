Return-Path: <SRS0=sY46=7C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEB3C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 20 May 2020 01:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9E420708
	for <linux-fstests@archiver.kernel.org>; Wed, 20 May 2020 01:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KryYcvgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgETBLm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 May 2020 21:11:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50361 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726178AbgETBLl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 May 2020 21:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589937099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8v25aa/LREJwVLFRcQMuyasLMAeHNUoF9i3btYsSqg=;
        b=KryYcvgJ2o8R0uAFZUGPyVmphNcnp3kk1TiAg5+ZqygNuwbTZHrXAYohA151xVo4nZPhs8
        Xi5wfwgdjCJP3P++gfNjP28eIxAiTe8rVkkBRcAMLezx5Fhtwep3/qfCU/1ubB2AGXJGx4
        9Md5RmJE7axJYAwEXRkTC/yx/XQOTr4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-_XUG8zuZP1enASy2D3sBbA-1; Tue, 19 May 2020 21:11:37 -0400
X-MC-Unique: _XUG8zuZP1enASy2D3sBbA-1
Received: by mail-pl1-f198.google.com with SMTP id f3so1322622plo.14
        for <fstests@vger.kernel.org>; Tue, 19 May 2020 18:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8v25aa/LREJwVLFRcQMuyasLMAeHNUoF9i3btYsSqg=;
        b=s/3SnauhwrKdBRFETFWrNNp9tna9ZPQy3I4DwHwb+eJzo4Wj2wjnnEtAP8AvVJA83+
         yGF7jn7mVntO1kRkF7iBqrthSiEVY0r2bpgyV09HdofUgBdKNofIMVPsafkSbK1YyFov
         hvuIOupOrVtmneEkL/owP2GwPQmJg5dZwK59b8DZtm6RrhiJGUVsILBIYS5yMgvrhYZr
         0tr4VC/jnWta6ulx3zYB6lw+GpfUm8SAR9sr6X4gjRguIeKPPBaEeXdA7Sw/VVZxDfmQ
         g4dkq90xD0oZJpwsAJi6V/LBGimvJV0xRlbQFBH4/sXbrFGTzeQJqiAfMoSfhJSDSUV7
         D7SQ==
X-Gm-Message-State: AOAM531zfPXfzkMeXhMoFkw+O2X77R+8mzyi18+4gCyHAudFjhQgkkQb
        czgJNxe4KiikZFQXhC4/fUtfYTChMknRxcac7x5LA6bdjESttE0KSXE8yDeU7bHjkS0eOpinH26
        M1WdLJSLv9b3a+zfc5A==
X-Received: by 2002:a17:90a:c584:: with SMTP id l4mr2363055pjt.195.1589937096231;
        Tue, 19 May 2020 18:11:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznLKtn1gkvxBvVUw1k2rYdaefsIDsraPfZca9/giJlh0GqcsB2YoyPL0lQr2LqmVmN59uw7A==
X-Received: by 2002:a17:90a:c584:: with SMTP id l4mr2363023pjt.195.1589937095817;
        Tue, 19 May 2020 18:11:35 -0700 (PDT)
Received: from don.don ([60.224.129.195])
        by smtp.gmail.com with ESMTPSA id d20sm565231pjs.12.2020.05.19.18.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 18:11:35 -0700 (PDT)
Subject: Re: [PATCH] xfstests: add test for xfs_repair progress reporting
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <20200519065512.232760-1-ddouwsma@redhat.com>
 <20200519160125.GB17621@magnolia>
From:   Donald Douwsma <ddouwsma@redhat.com>
Message-ID: <3b112c63-b246-62b3-c74e-4146da0b68d8@redhat.com>
Date:   Wed, 20 May 2020 11:11:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519160125.GB17621@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 20/05/2020 02:01, Darrick J. Wong wrote:
> On Tue, May 19, 2020 at 04:55:12PM +1000, Donald Douwsma wrote:
>> xfs_repair's interval based progress has been broken for
>> some time, create a test based on dmdelay to stretch out
>> the time and use ag_stride to force parallelism.
>>
>> Signed-off-by: Donald Douwsma <ddouwsma@redhat.com>
>> ---
>>  tests/xfs/516     | 72 +++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/xfs/516.out | 15 ++++++++++
>>  tests/xfs/group   |  1 +
>>  3 files changed, 88 insertions(+)
>>  create mode 100755 tests/xfs/516
>>  create mode 100644 tests/xfs/516.out
>>
>> diff --git a/tests/xfs/516 b/tests/xfs/516
>> new file mode 100755
>> index 00000000..5ad57fbc
>> --- /dev/null
>> +++ b/tests/xfs/516
>> @@ -0,0 +1,72 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2020 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# FS QA Test 516
>> +#
>> +# Test xfs_repair's progress reporting
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	_dmsetup_remove delay-test > /dev/null 2>&1
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/dmdelay
>> +. ./common/populate
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs xfs
>> +_supported_os Linux
>> +_require_scratch
>> +_require_dm_target delay
>> +
>> +# Filter output specific to the formatters in xfs_repair/progress.c
>> +# Ideally we'd like to see hits on anything that matches
>> +# awk '/{FMT/' repair/progress.c
>> +_filter_repair()
>> +{
>> +	sed -ne '
>> +	s/[0-9]\+/#/g;
>> +	/#:#:#:/p
>> +	'
>> +}
>> +
>> +echo "Format and populate"
>> +_scratch_populate_cached nofill > $seqres.full 2>&1
>> +
>> +echo "Introduce a dmdelay"
>> +_init_delay
>> +
>> +# Introduce a read I/O delay
>> +# The default in common/dmdelay is a bit too agressive
>> +BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
>> +DELAY_TABLE_RDELAY="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 100 $SCRATCH_DEV 0 0"
>> +_load_delay_table $DELAY_READ
>> +
>> +echo "Run repair"
>> +$XFS_REPAIR_PROG -o ag_stride=4 -t 1 $DELAY_DEV >> $seqres.full 2>&1
> 
> Hmm... if the scratch device had an external log device, this raw
> invocation of repair won't run because it won't have the log parameter.
> Normally I'd say just use _scratch_xfs_repair here, but since there's a
> delay device involved, things get trickier...
> 
> ...or maybe they don't?
> 
> 	SCRATCH_DEV=$DELAY_DEV _scratch_xfs_repair -o ag_stride...
> 
> might work, seeing as we do that in a few places...
> 

Thanks, that works a treat!

>> +cat $seqres.full | _filter_repair | sort -u
> 
> You also might want to redirect the repair output to a separate file so
> that you can filter and sort /only/ the repair output in the process of
> logging the repair results to stdout and $seqres.full.

*nod*, that would be much clearer. 

Cheers, 
Don

> --D
> 
>> +
>> +_cleanup_delay
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/xfs/516.out b/tests/xfs/516.out
>> new file mode 100644
>> index 00000000..bc824d7f
>> --- /dev/null
>> +++ b/tests/xfs/516.out
>> @@ -0,0 +1,15 @@
>> +QA output created by 516
>> +Format and populate
>> +Introduce a dmdelay
>> +Run repair
>> +	- #:#:#: Phase #: #% done - estimated remaining time # minutes, # seconds
>> +	- #:#:#: Phase #: elapsed time # second - processed # inodes per minute
>> +	- #:#:#: Phase #: elapsed time # seconds - processed # inodes per minute
>> +        - #:#:#: check for inodes claiming duplicate blocks - # of # inodes done
>> +        - #:#:#: process known inodes and inode discovery - # of # inodes done
>> +        - #:#:#: process newly discovered inodes - # of # allocation groups done
>> +        - #:#:#: rebuild AG headers and trees - # of # allocation groups done
>> +        - #:#:#: scanning agi unlinked lists - # of # allocation groups done
>> +        - #:#:#: scanning filesystem freespace - # of # allocation groups done
>> +        - #:#:#: setting up duplicate extent list - # of # allocation groups done
>> +        - #:#:#: verify and correct link counts - # of # allocation groups done
>> diff --git a/tests/xfs/group b/tests/xfs/group
>> index 12eb55c9..aeeca23f 100644
>> --- a/tests/xfs/group
>> +++ b/tests/xfs/group
>> @@ -513,3 +513,4 @@
>>  513 auto mount
>>  514 auto quick db
>>  515 auto quick quota
>> +516 repair
>> -- 
>> 2.18.4
>>
> 

