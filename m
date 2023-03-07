Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16227C6FD1A
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 16:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCGQqj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCGQqM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 11:46:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB122A08
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 08:43:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3EF8B818E8
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 16:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CD3C433D2;
        Tue,  7 Mar 2023 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207388;
        bh=uWqwffXLda/vMsSswhics/hS7JP2wk9Tw1JOIHfWgQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRL9iYvz5AF8/Va4P6XQrVjAEEW8gctgOuAGv1Y50/HaAae4m8A+VCjS5kbIJf/Kd
         fe8REZ1ELP2BUjfZGK8Af2LtBwYO+FpbJK8n+6GWlfNIRjL0W9XeZKT9KkZ+0Gp4m3
         Q9IbTRar2mj3xMgmVI9HVMYS8/5sfsHyV1ysyMnVieVnDGUDVTBet/ruR4Id4/MtuL
         zOEWB05f7sOi6op8qGXOGyzgS8xu1kmevRKccvLXfm/FDILN9WwNrNjMJLJZGOCn62
         DO0wAYpNSbjfJyM/aeS6slzJlNhlfthHfuylPFsxijmMHaC/tCJ8jMpk+T6WfjwsgR
         ckwKIG0UwBeBQ==
Date:   Tue, 7 Mar 2023 17:43:05 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 02/11] vfs: Fix documentation typo
Message-ID: <20230307164305.3xi2xzkwt5jsgv4q@wittgenstein>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-3-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307114507.332309-3-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 07, 2023 at 12:44:58PM +0100, Rodrigo Campos wrote:
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
