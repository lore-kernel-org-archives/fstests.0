Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768EC61DA4
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Feb 2023 14:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBFOvU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBFOvQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Feb 2023 09:51:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5D128868
        for <fstests@vger.kernel.org>; Mon,  6 Feb 2023 06:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBD94B811B3
        for <fstests@vger.kernel.org>; Mon,  6 Feb 2023 14:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0C5C4339B;
        Mon,  6 Feb 2023 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675695068;
        bh=CCzVcQgthB8wS/+cskZVc3j841SJqFQFcXNs8844nok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7gflCEl2TNh9RuaOyld/pWqaG6LCGzp8OZLZamOjpgS3hmkniiORrAjZ7NA7jc0Z
         4yuqntsO7wrftfCs0vNBn8VmFmvAFPMfHyD9/1SKzH9xPQJvfoLQTuvAzbWiBl+eI1
         OgkRjfZB8tNtLAuUG+Lyu/Ra2Q6hXbmQMEYaTHBe2u6zVNCBgdJJXinvtOpsgyKzWG
         yO9nqaavWG6ShIJUlCC+5uV4J8FuXpuOdjPk+Omieba/SQFc/3CIOnTXQcZRH46C+Y
         becXVmvYeKQe2+Ea7aIHDmXtR2vVxcZnwokM8WCiaAYeizhss3K262wNvbDYVGtBQd
         d96fHyfRXQjyQ==
Date:   Mon, 6 Feb 2023 15:51:04 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common: Do not chown ro mountpoint when creating
 idmapped mount
Message-ID: <20230206145104.hxuvcsxvml7v36ms@wittgenstein>
References: <20230203143545.23689-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230203143545.23689-1-gniebler@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Feb 03, 2023 at 03:35:45PM +0100, Gabriel Niebler wrote:
> The function _idmapped_mount tries to change the ownership of the mountpoint
> for which it aims to create an idmapped mount, to ensure that the mapped UID
> and GID can actually create objects within it. Some tests set up a read-only
> mount, however, which lets the chown call fail. This patch fixes the
> function to check whether the mount is read-only and skip the chown, if so.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks for fixing this!
