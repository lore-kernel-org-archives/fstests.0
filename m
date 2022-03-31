Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE04C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 11:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiCaLkQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiCaLkP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 07:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701C27B1E
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 04:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D395613F5
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 11:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72ECC340ED;
        Thu, 31 Mar 2022 11:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648726705;
        bh=taZzdvz+I8kDM8XZz861aHG7BRA0A28DGvSxvBkRIpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go2S8qaIm4QjV2/kqUMNESDyzMGDxDv7z+AmML5vJVkOrUnNedyAVpn31lF02w5YR
         lRkjCAdbKoqCraqGUvbfBjU5gPDBokP7fRGyQDluO8dziAXYY/IAbYPV1Msx63TMha
         5RvJsDTUUXbDMt7pwL6XuG9QsgE/GtJ6k4eLGiXd0jrPv8r1iOgH2Y54G6XYQ6z83N
         Vhhvfk2D+i0+bXhPl4cRfhjDleuRCapq/fbe6GW2JvJnKoKZLwNo7yi+3inxoEUvHv
         JuksWQrswwsn9QIxYEz1ibvbawhm3uBk8VtMHUXZN4K+VJBs88ALuklFHTJ50989g3
         XBRreVMWz2DRw==
Date:   Thu, 31 Mar 2022 13:38:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/633: Avoid failure without CONFIG_USER_NS
Message-ID: <20220331113821.huqebwnjp2lb6fcn@wittgenstein>
References: <20220331111920.8377-1-jack@suse.cz>
 <20220331111920.8377-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220331111920.8377-3-jack@suse.cz>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 01:19:20PM +0200, Jan Kara wrote:
> Some tests in idmapped_mounts fail without CONFIG_USER_NS because they
> have implicit dependence on user namespaces and these tests are run
> despite idmapped mount support not being detected. Detect whether at
> least user namespaces are supported and skip tests needing them when
> they are not.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Thank you. Looks good,
Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
