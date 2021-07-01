Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7010C11F64
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Jul 2021 14:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFAD61403
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Jul 2021 14:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhGAOmI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhGAOmI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 1 Jul 2021 10:42:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5BFD6140C;
        Thu,  1 Jul 2021 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625150377;
        bh=nKVMnaaPD8SdRCAlhgi0KbgzL39fEBTKEHKnd+egGNI=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=cJu5tc1uL5WNXBHDU0dreaWZTbWudVad+Nc4iLPYkj5RkMDUghT1GvfgxBxpmfGlt
         YSYMNA3/+jh2B/7npFOE8fzOEKJRoyETNuNIAxHWOlnrdFvM/Ur1dTUrHwuc59e+Jj
         pD/ekv/KC/hGm8z2nrmdsoSRnpG/PdbVe5Iehfmam6gMvg2EsskRBs3sp9h99I2lZc
         9E8xfnwnRNbxcfRHqsgTlQ7TRX8EbH02fw0O8qkoE4aLYaD/lSSFj2nshe/iDCw0R9
         ADabY/wJ2oYni17s6yJezLL/JjGuzg2iZ0apAdo0GRcVFntaoBwRfMY0R7crN2DCpE
         3GFDBrDVV3NDw==
Subject: Re: [PATCH v3 1/3] generic/042: make a bigger img for f2fs
To:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org
References: <20210630113736.551843-1-sunke32@huawei.com>
 <20210630113736.551843-2-sunke32@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net, guan@eryu.me
From:   Chao Yu <chao@kernel.org>
Message-ID: <cc9344d8-9bb7-d876-71b1-56937b16338c@kernel.org>
Date:   Thu, 1 Jul 2021 22:39:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630113736.551843-2-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2021/6/30 19:37, Sun Ke wrote:
> f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
> f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change again.
> So, just set it to 128M.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>
