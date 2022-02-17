Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F7C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Feb 2022 08:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiBQIMd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Feb 2022 03:12:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiBQIMc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Feb 2022 03:12:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4363C13F00
        for <fstests@vger.kernel.org>; Thu, 17 Feb 2022 00:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b4XnidwsSOlu84xkodmv7toM2Dcr8N/7pbvN0klpGs0=; b=jzs+0DgdQ9oTuykeygE7IjmUMc
        l968Ig6pA/EGiuTjtilo/Lhhtvv/Jy4/7l6cUPrhXrvMVFY+f8EqfFeTizGcdtrWXtr9MsGHUJg4z
        t8cZ1i4RaFoDvKYrNb5PFzIjrMoccoOsnRJU/k/+yqfEvGwXQbD3XCS9iyacriSjAxUB6qdpIq3eG
        vKJWzWzIsuAZUs8KK4t0WhYqruwl6n2juKe4KIVPemIPe7WanwGMkwDK9/HbMh0Vs52yD+f+1yj7H
        KzBtFWcY+kb1oTOQNcmFEGBv6arys073n91mxfi6A68PLqbtkm0ONCVulxYSAGSm8LxyPW38staww
        B25JhcNA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKbti-009NaM-Uy
        for fstests@vger.kernel.org; Thu, 17 Feb 2022 08:12:18 +0000
Date:   Thu, 17 Feb 2022 00:12:18 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/config: fix use of
 MODPROBE_RM_PATIENT_TIMEOUT_ARGS
Message-ID: <Yg4DYsM26XM1O2gc@bombadil.infradead.org>
References: <20220208213754.3724193-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208213754.3724193-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 08, 2022 at 01:37:54PM -0800, Luis Chamberlain wrote:
> When patient module removal support is detected on kmod
> (note that this is not yet even merged onto kmod yet but
> work in progress) the arguments required for it are not being
> set yet. This was a typo, fix this.
> 
> This issue was spotted using shellcheck from blktests when adding
> patient module removal support there. I'll post a patch next to
> let folks evaluate if we should embrace shellcheck on fstests as
> well.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

*Poke*

  Luis
