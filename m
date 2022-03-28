Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF25C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Mar 2022 03:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiC1Du1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Mar 2022 23:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiC1Du0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Mar 2022 23:50:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E17A13DD0
        for <fstests@vger.kernel.org>; Sun, 27 Mar 2022 20:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0438B80D13
        for <fstests@vger.kernel.org>; Mon, 28 Mar 2022 03:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6061AC004DD;
        Mon, 28 Mar 2022 03:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648439323;
        bh=ncL8VxubfzfZ7b1grespf5LSNaqvF/YurFbhYD9Cg8E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Yivf2euGEalJtibgIbINrF87hT0GmxnKTV7+fzxsgicwknY0Dd4wi1VksXcPVXBQP
         So8hiKhTtMIV63b1eX0Inz4XF7Xw3lslBIsuVAQ2Uv4Zepz+BUGNcQ1WUbB/LntPkz
         WbmePHhV4bzfRcLi+y3W3dOmqVqatrZ4WRsjyNtOOy8TsY/cGnvsSB0nALQdV0mApE
         km6aTNlg93CwrqATqetcQsoh7NXP4Jn834Ttkx7byCiuts9h/FlUembHmgkh3IB9F2
         kl/Yv4AfwpIusZ+f86l3Lam+EdoHBiUCagftqkBISfdajyvFXkZ8hyh80WvcGS1Aa+
         Rg649hMFMfFLQ==
Message-ID: <16c081ae-fc87-c9d5-0bac-3482f68c58d5@kernel.org>
Date:   Mon, 28 Mar 2022 11:48:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [f2fs-dev] [PATCH v3] generic/066: attr1 is still there after log
 replay on f2fs
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org, guan@eryu.me
Cc:     jaegeuk@kernel.org, david@fromorbit.com,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220323083724.55902-1-sunke32@huawei.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220323083724.55902-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/3/23 16:37, Sun Ke via Linux-f2fs-devel wrote:
> The test fail on f2fs:
>       xattr names and values after second fsync log replay:
>       # file: SCRATCH_MNT/foobar
>      +user.attr1="val1"
>       user.attr3="val3"
> 
> attr1 is still there after log replay. f2fs doesn't support fs-op level
> transaction functionality. so it have no way to persist all metadata
> updates in one transaction.  We can use "fastboot" mountoption for this
> case, so during last fsync on qwerty, f2fs can trigger a checkpoint
> which will persist all metadata updates before fsync().
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
