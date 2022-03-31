Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C93C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 11:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiCaLjy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiCaLjx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 07:39:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D844D207A00
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 04:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F8F1B8206A
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 11:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7820DC340ED;
        Thu, 31 Mar 2022 11:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648726684;
        bh=TaoRlzpxEceNfFNbsqqPuW8NcSOJNp9ctxjSmr0GsFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bVH2eI1+1oESe5D5chkYTpnCCt9SSpcTmudJodIpEP7HzIJk1UsdIXhY9Fth557Zs
         vRttXIjjHKRkBKU4XHeyQ1dEzjIV639mEOG+XC+rMVAweWlUcwyc9b25n1QoA14Am8
         q6TD3CW8PPWi6KKBTZv44an0N+HQjAZXetJwCGWFaNWV4Di1lXiPLpMq/JtxgwzqoP
         +8KxOwfVgcjGnEavYuZdhmaXbMn0zRqK7j1MAn/OTpE6O9YeJ84zVcShH+qKodAJcn
         CxJ2otCU+u6UlXNzpmYFCaXzuAzaLm4cGeZkzB3ukCYBJSrp/03Ukn9JwTZSiMHl3b
         EdTWepvH9XFzw==
Date:   Thu, 31 Mar 2022 13:38:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] idmapped_mounts: Prepare for support for more
 features
Message-ID: <20220331113800.3sds7ciys3catyps@wittgenstein>
References: <20220331111920.8377-1-jack@suse.cz>
 <20220331111920.8377-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220331111920.8377-2-jack@suse.cz>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 01:19:19PM +0200, Jan Kara wrote:
> Currently idmapped_mounts tests fail for kernels without CONFIG_USER_NS
> because some tests are run despite missing support for idmapped mounts
> and they implicitely require user namespace support. Prepare
> idmapped_mounts to support more features a test may require to reliably
> run.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Thank you. Looks good,
Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
