Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D47C6FD1D
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Mar 2023 13:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCNNRk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Mar 2023 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCNNRW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2023 09:17:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6B26BC2D
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 06:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE80FB81891
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 13:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B7DC433EF;
        Tue, 14 Mar 2023 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678799592;
        bh=qXBeW64mVaiDwi8W+GDtR3qih4Rig042H2jEogfLmEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCKZHS6YrIQgj28uZ04etApJC80zaTq/4M36m562SbkvcrQEEa0T5d/HURDuRJmK8
         +4a37X6FMqnQltZ+siA3zZv7IRmUu2EfApEpjeJsDBa3CuvqIeQaVIBDfcSF0JkrFO
         hJmnHnCwBHu72Q89PpQEucDIjGNLBFzkAWTOxGb3CEVvH7V70cQsxT1BF27Kxfvdbl
         vgllll/PnDbnZPXn266Ke9Fqwh6ZKyAopTsDSuaLAVuhTLZaV7gJCDQYRmu6DF7ZtK
         Ep9gJHMvpiDAs50K5C8ORZfx/o6x2A0cBt910TdhkD2ipwJUsdqpXCrpl0wSMJuo6K
         BKgtNNe5F/K0A==
Date:   Tue, 14 Mar 2023 14:13:08 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v4 9/9] vfs: Add tmpfs tests for idmap mounts
Message-ID: <20230314131308.2vn6gv7pgp23gjek@wittgenstein>
References: <20230314114511.128207-1-rodrigo@sdfg.com.ar>
 <20230314114511.128207-10-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230314114511.128207-10-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 14, 2023 at 12:45:11PM +0100, Rodrigo Campos wrote:
> This patch calls all tests in the suite s_idmapped_mounts, but with a
> tmpfs directory mounted inside a userns. This directory is setup as the
> mount point for the test that runs nested.
> 
> This excercises that tmpfs mounted inside a userns works as expected
> regarding idmap mounts.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

Ok, I think this is good enough now. Thanks for working on this. Very
happy that you followed through,
Acked-by: Christian Brauner <brauner@kernel.org>
