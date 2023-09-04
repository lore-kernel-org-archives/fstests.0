Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823B5C71153
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Sep 2023 12:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjIDMfw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Sep 2023 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjIDMfu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Sep 2023 08:35:50 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CDBCCE
        for <fstests@vger.kernel.org>; Mon,  4 Sep 2023 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tVQxG4U8JIt8u/ge+besXdoirs6fWE8pthrBo5rm2eQ=; b=omnE0ukrbzhdOm+cP2Kouj181B
        cjdmtr/3/UfY7SCZGjYA93tQ6IKykoEuzQQCU6NmXZ5e3WukDXW8+u6QdseGuZdYZeTS+9l+EKl/M
        FzJwN/rUmK8uB4MG6dVI+c540kMGTkYTAVPlx8FY3/UFQOd0EXAjpYNEbGB9T7xbIM/kLP/o97NQJ
        GaXYowVBoVP15ld2PQk+nBSb9iWYfINVgIN4u7nA9Zxb/AeqnLZzwgQ/prFFdetZqX6UJ7zTiAOXV
        8LcsBB3e8tHNU0zkwKheqR/xMYoFl7MDkI0juwbmTexiHL1FGAm1lNGPJocmfAHmAWI4BVelC8cfx
        Ct2p3gZQ==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qd8nt-0021vL-Jj; Mon, 04 Sep 2023 14:35:41 +0200
Message-ID: <e9a3806c-8dd5-f068-d19c-648e4f28ff48@igalia.com>
Date:   Mon, 4 Sep 2023 09:35:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] btrfs: Add test for the single-dev feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, kernel@gpiccoli.net,
        kernel-dev@igalia.com
References: <20230830221943.3375955-1-gpiccoli@igalia.com>
 <85745478-dcb2-2815-709a-aa9e52184d1b@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <85745478-dcb2-2815-709a-aa9e52184d1b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 04/09/2023 03:05, Anand Jain wrote:
> 
> 
> Thanks for the test cases. These test cases might need to be updated as
> per the final changes in the kernel patches.
> 

Hi Anand, thanks a lot for the review! Very useful to me.

Now, what updates are missing? I've worked this fstests case after V3
was done and tested with that. Is there any missing piece you noticed?


>> [...]
>> +_require_scratch_dev_pool 2
>> +_scratch_dev_pool_get 2
> 
> We can use
> 
> _scratch_dev_pool_get 1
> _spare_dev_get
> 
> So scratch devices are set to SCRATCH_DEV and SPARE_DEV.
> 
> [...]
> we can use something like:
> 
> test_dir="${TEST_DIR}/${seq}"
> scratch_mnt_copy=$test_dir/mnt_copy
> 
>> +
>> +DEV1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
>> +DEV2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $2 }')
> 

Great hints, I'll change and send V2 - thanks!


> 
> A general rule of thumb is to have one test case per file.
>

Well, I agree but what I'm doing in fact is testing single-dev feature
in this test case, so it's self-contained and single-scoped, only
single-dev stuff! I personally wouldn't see advantages having 3 tests
doing almost the same thing, but if that's a requirement, I can change.


> [...] 
>> +$MKFS_BTRFS_PROG -O single-dev $DEV1 >>$seqres.full 2>&1
> 
> _scratch_mkfs "-b 300m -O single-dev"
> 
> The '-b 300m' option prevents the below 'dd' operation from taking
> too long to complete on larger devices.
> 
>> +dd if=$DEV1 of=$DEV2 bs=64M conv=fsync >> $seqres.full 2>&1
>> +
>
> dd if=$SCRATCH_DEV of=SPARE_DEV bs=300m count=1 conv=fsync >> 
> $seqres.full 2>&1
> [...]
> 
>> +mount_btrfs $DEV1 $SCRATCH_MNT/$DIR_a
>> +mount_btrfs $DEV2 $SCRATCH_MNT/$DIR_b
> 
> 
> _scratch_mount
> _mount $SPARE_DEV $scratch_mnt_copy
> 
> _spare_dev_put
> _scratch_dev_pool_put
> 
> 
> status=0
> exit
> 

That is very useful, will change for sure! Thanks again.
