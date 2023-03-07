Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA0C6FD1A
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 16:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjCGQzO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCGQyj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 11:54:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E869CFE5
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 08:50:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E7EAB81985
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 16:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA55C433D2;
        Tue,  7 Mar 2023 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207827;
        bh=Nlp97z2xlByYGdPgV3+XT76Vcd84s3cbXW2jbLJrtxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8PYGNi7ZGRtAVD6jRCiWJNWE5wNDeLHLDxCzMgAJ71tYUKIwW3QcbOFfdnOaKc/9
         c0MFlm0HlH05j94x664MiEVSR0jjzBYFPOfD0PDONn45pE8aIPPiCzEl3cDyrIesn1
         kdi6qsg3/GIxNJbiVZuZG9B422fnYF0kFJHtiXJV6qgkSZa0+tqFiEntH6MaZLoxcv
         pYCM04Zs8D7V69B4DtHU/qxlllvbDU+fJarJSlP1uhFqSfwPg1VdbvPlkenizioDD2
         wZtWBQUBjKN3GPLleeZUqhBNejG1nr7gfeEvsT6UQuN2nT54oROosdvJjKdwW6htx1
         rP/CAktvwhG4Q==
Date:   Tue, 7 Mar 2023 17:50:24 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 06/11] vfs: Prepare tests in &s_idmapped_mounts to be
 reused inside a userns
Message-ID: <20230307165024.p72x3irzn36kt6bm@wittgenstein>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-7-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307114507.332309-7-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 07, 2023 at 12:45:02PM +0100, Rodrigo Campos wrote:
> Future patches will call these tests within a userns. So, let's skip
> operations not allowed inside a userns.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

On newer kernels you can always do:

mknodat(open_tree_fd, CHRDEV1, S_IFCHR | 0644, makedev(0, 0)))

but you'd still need the t_inside_userns then anyway so sure,

Reviewed-by: Christian Brauner <brauner@kernel.org>
