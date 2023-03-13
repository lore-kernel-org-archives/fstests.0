Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82874C61DA4
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 10:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCMKhi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 06:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCMKhc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 06:37:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C350FB5
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 03:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 108E9B80EFD
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 10:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC47AC433EF;
        Mon, 13 Mar 2023 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678703837;
        bh=/u6sPzUsBReUcNPbmK/rh1em1rDDKb3Nv5GcyEitlhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rn6uDZqXDJL4aIhr0blbr8f8eSs7L9F5/0+oFRkGcchNfJgbChkC94sgowLv2XluZ
         6QDXbOQc04czJ3yGQcDfYf1aDjHDndWQcG4YcJcPPSmheLDi1hogDwpNR1l79RZjsC
         /ovaYaopJyCdGzf88Fg4+Z3FK8XC8VmLBNpNIE1+d/7gWIxnHnhJe3sBo9GxIQKvJe
         doI3qwIkuC2SgTR8A2uzRaWmnixgJvdkd3XJpBEwtqN6S6neFsDCs+ENwJi+YDf2O6
         omdI3IXKv7xyTBFZzPRZzu/F2Fw9YhVm/eZilc2di7UatsnPSL/69RxcV40sTGj9f/
         lIVY7wbPWcGUQ==
Date:   Mon, 13 Mar 2023 11:37:13 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 06/11] vfs: Prepare tests in &s_idmapped_mounts to be
 reused inside a userns
Message-ID: <20230313103713.bcx5saexciqctbgo@wittgenstein>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-7-rodrigo@sdfg.com.ar>
 <20230307165024.p72x3irzn36kt6bm@wittgenstein>
 <f8aaae1e-9ac2-d7e9-7c56-158c9b64b5f9@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8aaae1e-9ac2-d7e9-7c56-158c9b64b5f9@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 08, 2023 at 12:34:49AM +0100, Rodrigo Campos wrote:
> On 3/7/23 17:50, Christian Brauner wrote:
> > On Tue, Mar 07, 2023 at 12:45:02PM +0100, Rodrigo Campos wrote:
> > > Future patches will call these tests within a userns. So, let's skip
> > > operations not allowed inside a userns.
> > > 
> > > Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> > > ---
> > 
> > On newer kernels you can always do:
> > 
> > mknodat(open_tree_fd, CHRDEV1, S_IFCHR | 0644, makedev(0, 0)))
> > 
> > but you'd still need the t_inside_userns then anyway so sure,
> 
> Actually, no, changing the makedev to that does the trick and it works
> inside a userns (at least in kernels where tmpfs supports idmap mounts).

Oh right, good point. We only need to care about kernels with idmapped
mount support for tmpfs. Excellent.
