Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87341C71153
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Sep 2023 12:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbjIDMi1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Sep 2023 08:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjIDMi1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Sep 2023 08:38:27 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D3EEC
        for <fstests@vger.kernel.org>; Mon,  4 Sep 2023 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sho65U1N9Fk8zN47f7Xng5AZ5Nv6IeamLCAGG3c2zfE=; b=loekBUP9nlomhdQzQvj44DdQj1
        +qhgY8nmV11QXsrb6/UbMN7bBL/R4yRQbn1ysJoiM90fAVBK22MgDEySeq/OEZnSviXEkT38tzFn4
        FCcgq0RPGQMuULJIHeqlTNAUwOAaT59Lbl+C7y20RBfcnxi8OOph+mXGXahVOHMXbn0fBsIAENapG
        Pg1jLhCzYkcs0qDx0NjTVIyHGoXQA0BRU/h/2dyN/jSA4cEYFgYcxybng0qEcNBuWxMEHV8+deTI/
        MNDGAE7Lr6XhJuVIu3fwwIH2cV7t6HUclUrYwNqfBAqopZM7XoqxRByTq6F3rxI1rS+WO8vSVbPc8
        cSmfJgPw==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qd8qT-0021yq-39; Mon, 04 Sep 2023 14:38:21 +0200
Message-ID: <331cf954-3951-b8fc-98b3-92d489c5caf5@igalia.com>
Date:   Mon, 4 Sep 2023 09:38:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Question about multiple scratch mount points
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
References: <5ac92006-6f06-196b-1acc-7380d8ca4a86@igalia.com>
 <6b45a808-491b-a6ad-a5b1-5776dd307462@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <6b45a808-491b-a6ad-a5b1-5776dd307462@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 04/09/2023 03:08, Anand Jain wrote:
> On 8/30/23 21:18, Guilherme G. Piccoli wrote:
>> Hi folks, I am new at fstests development so I have a question
>> that...might be silly, apologies in advance!
>>
>> How should I require to have 2 scratch mnt points for some test? I'm not
>> sure if necessary: what I'd like to accomplish is to mount the same
>> filesystem (present in the scratch device) twice, in different mount
>> points. One idea would be to just mkdir 2 folders under $SCRATCH_MNT/,
>> but I'm not sure if it's guaranteed to be writable before any mounts happen.
> 
> We can use $SCRATCH_MNT and $TEST_MNT/$seq/mnt_copy as showen in the 
> proposed test case.
> 
> HTH
> -Anand
> 

Thanks a bunch Anand!
