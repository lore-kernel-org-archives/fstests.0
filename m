Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D23C34047
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 15:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069A32465D
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 15:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="se6Dwo30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSPwq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:52:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33360 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSPwq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Feb 2020 10:52:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id h4so571202qkm.0
        for <fstests@vger.kernel.org>; Wed, 19 Feb 2020 07:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cm1/LXE7Ytqr2T/AcQs7X0yH22gIRdeSD8EBnupx4P0=;
        b=se6Dwo30Xq8bdgqxAMe6EBsQ4g0CEAyvq2gXmbME9QSDW3lHg/QTskcyun2+HIN3Uq
         mSthDABr9d7kinF2NsK+6640qwPAToK2hP6Q+wh4RLsZ6Zyo+lbQMuPzKmyF1iTu+i9B
         TUatoasxtSg+RejtbzWQPFnwsIM9utW/I+XZVctnVYKrbnLCARS0gu2kR6dHAnn/Wj4n
         DIgyg/XNDq8K5AM52MEGamSkSEkepdubcz8kxC64m5ig6j0LrJvpmt7YHXuSn5ic+MrU
         CrtUynbW/cgrVyOlqUTjGKtA3rtAcvhb2FksKRXghdRDd84/wTgAC+K3QRwt9Tb++cda
         uu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cm1/LXE7Ytqr2T/AcQs7X0yH22gIRdeSD8EBnupx4P0=;
        b=f7m5Jy2sxrJZnYcY4X8ZkOzfItCF/8UgpHpc6nUAT12wtG/hSPvxjJ5uLR49sgbDZM
         oiqgVMmVbDaPFlgVXWdTH4JJzpPfoqP5XWuUNR0WrEQo/rWJtg0fSKeLNj6/6yCtWtPg
         AkFyqDP6uVYTod2Kcvx92yoySWlTg6A+tT2Vgd7XOe6hcdnWKXgbbs1krq8zSR3D98pI
         YxN7ouFM7aqx39hc/FkZcl9HE80pC0ftaej1To3g0ZGrxmkApR+HnulEEN8TCDg8N4gQ
         zesjmJZ1gYGU+AcjKs/vjC3Ib0WkndegsBjGxm8iTQabuOVcv7WpGA0sDFi07WfGtlW8
         Vgxg==
X-Gm-Message-State: APjAAAXgrH2MfnaoHhbM+pdQqV3oOkPRV8yAopeFwteKagzTwY1j87iJ
        H+t26Lpj1scAopwZ9EkOluq4nw==
X-Google-Smtp-Source: APXvYqwp0I6dcRiCUwBY/gjCoR75OmXyJwXj/Dj9zSRkfFPT6PDjM8w6YeCN3UHaVBfA664xc9rUkQ==
X-Received: by 2002:a37:2710:: with SMTP id n16mr24557650qkn.235.1582127565007;
        Wed, 19 Feb 2020 07:52:45 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::3b69])
        by smtp.gmail.com with ESMTPSA id d3sm41183qkl.0.2020.02.19.07.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 07:52:44 -0800 (PST)
Subject: Re: [PATCH][v2] xfstests: add a option to run xfstests under a cgroup
To:     Brian Foster <bfoster@redhat.com>
Cc:     kernel-team@fb.com, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200218152712.3750130-1-josef@toxicpanda.com>
 <20200219154850.GF24157@bfoster>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7e7476f4-3edd-3bff-657d-3ab627b0a75f@toxicpanda.com>
Date:   Wed, 19 Feb 2020 10:52:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219154850.GF24157@bfoster>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2/19/20 10:48 AM, Brian Foster wrote:
> On Tue, Feb 18, 2020 at 10:27:12AM -0500, Josef Bacik wrote:
>> I want to add some extended statistic gathering for xfstests, but it's
>> tricky to isolate xfstests from the rest of the host applications.  The
>> most straightforward way to do this is to run every test inside of it's
>> own cgroup.  From there we can monitor the activity of tasks in the
>> specific cgroup using BPF.
>>
>> The support for this is pretty simple, allow users to pass -C <cgroup
>> name>.  We will create the path if it doesn't already exist, and
>> validate we can add things to cgroup.procs.  If we cannot it'll be
>> disabled, otherwise we will use this when we do _run_seq by echo'ing the
>> bash pid into cgroup.procs, which will cause any children to run under
>> that cgroup.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> v1->v2:
>> - Changed it from a local.config option to a command line option.
>> - Export CGROUP2_PATH for everything, utilize that path when generating our
>>    cgroup for the scripts to run in.
>>
>>   check          | 24 +++++++++++++++++++++++-
>>   common/cgroup2 |  2 --
>>   common/config  |  1 +
>>   3 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/check b/check
>> index 2e148e57..df33628e 100755
>> --- a/check
>> +++ b/check
>> @@ -72,6 +72,7 @@ check options
>>       --large-fs		optimise scratch device for large filesystems
>>       -s section		run only specified section from config file
>>       -S section		exclude the specified section from the config file
>> +    -C cgroup_name	run all the tests in the specified cgroup name
>>   
>>   testlist options
>>       -g group[,group...]	include tests from these groups
>> @@ -101,6 +102,10 @@ excluded from the list of tests to run from that test dir.
>>   external_file argument is a path to a single file containing a list of tests
>>   to exclude in the form of <test dir>/<test name>.
>>   
>> +cgroup_name is just a plain name, or a path relative to the root cgroup path.
>> +If CGROUP2_PATH does not point at where cgroup2 is mounted then adjust it
>> +accordingly.
>> +
>>   examples:
>>    check xfs/001
>>    check -g quick
>> @@ -307,6 +312,7 @@ while [ $# -gt 0 ]; do
>>   		;;
>>   	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
>>   	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
>> +	-C)	CGROUP=$2 ; shift ;;
>>   
>>   	-*)	usage ;;
>>   	*)	# not an argument, we've got tests now.
>> @@ -509,11 +515,24 @@ _expunge_test()
>>   OOM_SCORE_ADJ="/proc/self/oom_score_adj"
>>   test -w ${OOM_SCORE_ADJ} && echo -1000 > ${OOM_SCORE_ADJ}
>>   
>> +# Initialize the cgroup path if it doesn't already exist
>> +if [ ! -z "$CGROUP" ]; then
>> +	CGROUP=${CGROUP2_PATH}/${CGROUP}
>> +	mkdir -p ${CGROUP}
>> +
>> +	# If we can't write to cgroup.procs then unset cgroup
>> +	test -w ${CGROUP}/cgroup.procs || unset CGROUP
>> +fi
>> +
> 
> Do we need to fix up generic/563 to use this new $CGROUP value, when
> set? That test explicitly moves tasks to new/temporary groups, but looks
> like it resets back to the top-level CGROUP2_PATH group. I'm not sure
> how much that really matters since presumably the next test should move
> back into $CGROUP. Otherwise this looks reasonable enough to me.
> 

Wtf I had an explanation for this in my commit message, I must have exited 
without saving.

I tried to do this actually, and it ended up spewing because you cannot change 
cgroup.subtree_control for a cgroup you are currently inside of.  We can fix 
this by just making sure all controllers are enabled in our test cgroup, and 
then fix 562 to not bother messing subtree and just assume everything is 
enabled.  But since it's just one test and I wasn't sure if it would create more 
wonkiness I just left it as is.  I'm open to either solution, I just opted for 
the less change route.  Thanks,

Josef
