Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C62C6FD19
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 10:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCMKks (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 06:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCMKkr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 06:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925AF1708
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 03:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A88261182
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 10:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C46C433EF;
        Mon, 13 Mar 2023 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678704045;
        bh=uzAx4sz6syds93jpPiusuVHtq5YGOr+7xNJph7g818Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/EFKTwiDxM+YKARrD+/JFz8dXTwoFTYSbKPyO3q+r81fuhqyDw13GReC0PB0qR8f
         2S6xJMHJ4ym2ICSfrKcr8lUmPvNxm9I1xdj6J3noelrrpKclovBGqVpZxj4xL/Iqyd
         G4UGoq4uDtOABJX6IiSjqMBkrIvt8mfQ1u1TZo1Qm5lqQMXMisMAndG0fT9539oMVV
         d2bNmTzvtEwyVdPDh4rNYmsoyXQKG5v+WHnMSxgD8kSWPlrTRHhZzPyMX/esmqs4C6
         MVtKE5qpMvSA4YhvbZnZgpaYSiRLxcJO7yXtxIoHgalqAchFGWl3njuogbcr37ElDv
         rC+8/nErlYZTQ==
Date:   Mon, 13 Mar 2023 11:40:41 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v2 6/9] vfs: Prepare tests in &s_idmapped_mounts to be
 reused inside a userns
Message-ID: <20230313104041.dsl7xsy6cvvpvvue@wittgenstein>
References: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
 <20230308111343.510970-7-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308111343.510970-7-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 08, 2023 at 12:13:40PM +0100, Rodrigo Campos wrote:
> Future patches will call these tests within a userns. So, let's change
> the makedev major/minor to something that works inside a userns.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
