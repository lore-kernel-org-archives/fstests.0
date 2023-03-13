Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA5C6FD19
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 10:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCMKlp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 06:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCMKlo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 06:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1140F5
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 03:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 657FC611B5
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 10:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06A6C433EF;
        Mon, 13 Mar 2023 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678704102;
        bh=PcEv3tSoo7+qUqCQ27g6cyoFRSDyEBi09+L0fM+YUnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjxnP4NgjFafZyyG4yKzlHsxIWkg7USXh1OHie+hbIi8zFPFoVqr1+l84CZfEBXnT
         gSZCrfggNKHuy0baBYAo903Wtoil5gtqi+p20cOI+xszHza9JJmeSSmC5ZO7x9COXG
         1wBSDVClSaNHwm5gFUTbncMIteDKJiaxtEbiowmD1ov/R47c/8ooqCWAP1DxKfAHeU
         tHhuFN8KlDHdBvSu7YQw6keNqK2m1kwHexrRGlMfCIqjEh3jTanHesuABXgXIQ/v2h
         SoLwGOs7W85p4tjtQ86Y3cMiiDllWkWp1uxpCdD+jPqSN9niurACZhpobHM7UIkxh2
         xA823+Rz7z69g==
Date:   Mon, 13 Mar 2023 11:41:38 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v2 8/9] vfs: Export test_setup() and test_cleanup()
Message-ID: <20230313104138.as7hyq2gxvvqeu2b@wittgenstein>
References: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
 <20230308111343.510970-9-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308111343.510970-9-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 08, 2023 at 12:13:42PM +0100, Rodrigo Campos wrote:
> Future patches will call existing test inside another test, so we need
> to properly setup the test environment.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
