Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7849C678D5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 16:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCGQzo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjCGQzN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 11:55:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D687A926
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 08:51:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 756E4614C9
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 16:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE36C433EF;
        Tue,  7 Mar 2023 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207865;
        bh=viUIo3uuLso23k88uK13eJCWwo8yqAQQTIW9FwAVyBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iA9Zpd5BxViJGlYeCYctVuySfea7dn0ceywdtjaLOd6ZL9I3aROKUz844/ojh4nkT
         AQvXQOTHxegks83zgo3QUHa0/L4cQ323njL2CeoXodMM04TeLvGG0NtbwPIf9V/zak
         2NItc/ad4XoFdD90xLLNjNMG6UGdfC5nb7d3qATa91k856iulAOhXA2J2fQBYawKip
         d+kRXh09qC0lS64XbE+tJX/P6j5fk7Kxu46KwnwcZcyTQM/Tb0Pov9pWEE7EF6VvgO
         6A2WyyqcM43hnYYIvUBh/f+1IeEjs8m47Yg04wTDCHxrUPkoZN904eULt4cLQQLBtO
         6LYZLTNaYHm0w==
Date:   Tue, 7 Mar 2023 17:51:02 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 07/11] vfs: Make idmapped core tests public
Message-ID: <20230307165102.3pd7vwya2icwbs4l@wittgenstein>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-8-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307114507.332309-8-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 07, 2023 at 12:45:03PM +0100, Rodrigo Campos wrote:
> Tests on the suite s_idmapped_mounts are made public, future patches
> for tmpfs will call them.
> 
> While making them public, we add a "tcore_" prefix so we don't make so
> generic names public.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
