Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172A7C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Jul 2022 14:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiGYOUe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Jul 2022 10:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiGYOUd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Jul 2022 10:20:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C605BE037
        for <fstests@vger.kernel.org>; Mon, 25 Jul 2022 07:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B3D9B80EBB
        for <fstests@vger.kernel.org>; Mon, 25 Jul 2022 14:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A86C341C6;
        Mon, 25 Jul 2022 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658758830;
        bh=9qJhC9hs9kWPaQaRiOGCtVePOzNA763xKobne8lGmt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjZ6Pn6Qe95OLSca/GSdc2eQUALNBAzmF7+jGokrCreOVxewdf/55toX1KMctST7Z
         JU3iaKojetjV2A+3vLXYHmS/MVNx7mlQyvP0vWBWLm94bYi1/kTqVwj/scS/8Iupr3
         8ygokCdWc532D4hA0gXEJLbEt9pOYmlei/m5CIZkvNpxpyb+MHCMDzgh3dAJUWFEFR
         3pBZxExbfb8l5lZBFHw0RmVx7DssSValXyaULImwAB+jfN/KZbuT/JmFnR2qwjYHC5
         tQOqmWoNC3wilfblox8Xt33asSM1/tS4pqY70RKESNh49CuC2k3teO2ujDXceGtwz5
         //YW5uKPQygFQ==
Date:   Mon, 25 Jul 2022 16:20:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] vfs: Add new setgid_create_umask test
Message-ID: <20220725142020.rtc2mgfhcw47v4t4@wittgenstein>
References: <1653062664-2125-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <91470460-44cd-90a3-2e95-8e0fbefcd9ad@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91470460-44cd-90a3-2e95-8e0fbefcd9ad@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 25, 2022 at 07:55:23AM +0000, xuyang2018.jy@fujitsu.com wrote:
> 
> on  2022/05/21 0:04, Yang Xu wrote:
> > The current_umask() is stripped from the mode directly in the vfs if the
> > filesystem either doesn't support acls or the filesystem has been
> > mounted without posic acl support.
> > 
> > If the filesystem does support acls then current_umask() stripping is
> > deferred to posix_acl_create(). So when the filesystem calls
> > posix_acl_create() and there are no acls set or not supported then
> > current_umask() will be stripped.
> > 
> > This patch is also designed to test kernel patchset behaviour
> > "move S_ISGID stripping into the vfs"
> > https://patchwork.kernel.org/project/linux-fsdevel/list/?series=635692
> 
> The kernel patch has been merged into linux-next branch[1].
> 
> Does anyone review this fstests patch or give some comment?
> 
> I plan to remove setgid_create_umask_idmapped_in_userns and 
> setgid_create_umask_idmapped cases because they doesn't trigger bug.
> 
> Just treat it  as a kernel regression test ie 31c01ce18 ("generic: add 
> test for tmpfs POSIX ACLs") format.
> 
> CC Christian to confirm that whether need to test idmapped and 
> idmapped_in_userbs situation .

You've also sent a patch to LTP I saw which is good. I'm not completely
sure why you want to remove setgid_create_umask_idmapped{_in_userns}.
But as long as we have tests for setgid stripping on idmapped mounts I'm
fine with this.

Christian
