Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E143C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Mar 2022 20:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiCBUhC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiCBUhA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Mar 2022 15:37:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017A5BF52D
        for <fstests@vger.kernel.org>; Wed,  2 Mar 2022 12:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V/3iHUZhtIQ0bVFS+98JHAV7U0F9rptBrNuw8QKSaJs=; b=wopqsOOUkMjeY0gP5wSh9adiBS
        ruvX3vvPur7SpLs9M7zg2lMXeZMZMCO90xttUASoiDeoHf5ZoOJean5GTopJOJt3HWdlomTMhwpxf
        pN8kNwqvWJGCHwELnjTSYGcMOVhxqOOFNs6I0YuCTMCRjk56MhUFGt/7wuFgsPbPAtnQwWRIIC4gD
        u9O7FqGvf1F0twDzEwHuViZYLCuX4+vplOW5FcnlTQWrojP1OnkagcrRiZQVnTcIJOeXrwA5rG7Ty
        jSkKssszofBMG3Bp/t3Gl6YV7P3fYvxGGXclPFuPZMALyVI3axTEEwgvVIbFnRbsoSGczQeRrTYdY
        pcE0HHyg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPVhm-0046kW-RT; Wed, 02 Mar 2022 20:36:16 +0000
Date:   Wed, 2 Mar 2022 12:36:14 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     fstests@vger.kernel.org, nitheshshetty@gmail.com,
        p.raghav@samsung.com, joshi.k@samsung.com, arnav.dawn@samsung.com
Subject: Re: [PATCH] generic/108: use sysfs values for logical,physical block
 size in scsi_debug
Message-ID: <Yh/VPpBcF4qDt/AC@bombadil.infradead.org>
References: <CGME20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd@epcas5p3.samsung.com>
 <20220301212947.28660-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301212947.28660-1-nj.shetty@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 02, 2022 at 02:59:47AM +0530, Nitesh Shetty wrote:
> scsi_debug device used for test, is created with assumption of 512 bytes
> logical and physical block size.
> This causes error in lvcreate step, when SCRATCH_DEV device lba is not
> 512 bytes. This can be solved by reading block size from sysfs of device.
> If sysfs is missing fallback to 512 bytes as default.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
