Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A57C6FD1B
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 16:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCGQqA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjCGQp1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 11:45:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F7943B6
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 08:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7EEFB8197D
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 16:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710E0C433EF;
        Tue,  7 Mar 2023 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207348;
        bh=cEHALJSQPQJRIuLsfBur+EKwNGq4pfh0IJLEOVxtcBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bj7GPqsO6bwHDKEc71d8+771fsISkQ97OUfxXv+ys/GsDAPIAfKeJP5M/MAgiuGEV
         RLAEkEq8QvODNMaphKCOwcTElM57sYo1/Z2PyXzbOfsalzTzeNaC62G6dq3qrYP5Te
         apoCN1NMpv+qsM5Bhn85T9pCNuabYej9tq8mIlvZmbXmSvPWLM5z00qMbl7lzv6vv0
         oujitVmZ6nJux7pnryNiERVyqMDRe9y/dnYKlPkO4R6kKS5S25XgWoUJma8/ZLTVh8
         bs+bc2FFHx5PSS3FrmDTJu0n3vjRR00FAXNtKOjUOsr/g9BRpuTVxBJyR4ZysjbVRW
         ivWz9xvqNXWhw==
Date:   Tue, 7 Mar 2023 17:42:24 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 01/11] vfs: Don't open-code safe_close()
Message-ID: <20230307164224.uptpmicdp2tkjwjc@wittgenstein>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-2-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307114507.332309-2-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 07, 2023 at 12:44:57PM +0100, Rodrigo Campos wrote:
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
