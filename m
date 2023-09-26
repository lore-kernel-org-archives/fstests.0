Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E8CE7D27A
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Sep 2023 10:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjIZKgH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Sep 2023 06:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjIZKgG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Sep 2023 06:36:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00775126
        for <fstests@vger.kernel.org>; Tue, 26 Sep 2023 03:35:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7340C433C8;
        Tue, 26 Sep 2023 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695724559;
        bh=QXsmVLXsjGpk2LDtB6AmQr5lIzUl31WSXnjbiJhrEEA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=mgzNlCRAhZrhkmH9YI4mDEbArYYCz6iDtesAqAhjFXSNrSIXfNiw8g608qRcYaAls
         nudgB4WQWsoCdxR/YLz77ZfTgyBPnJgu+zk99OJuPUenAzA19UgvSVcKIw4uUCssrG
         uK7N0L30owcxV4r/26ho5mVVHNDF1FWit2WhuO+cj8PYhg7DFA1uLOpFrGVzNb1/40
         YqjNZIV/xU+k1pog86LHcS3ead+jEgDIYihCPVcpSKTbg5qV4+Gt4vIvBWyrfnrEkJ
         r0dFisEk2Fb2kLDrTRxXHkStKoONj6V6cMnstZc1q6xvknAJ7R66R2Ioy0M457evBh
         kF2e1u4RJjP3g==
Date:   Tue, 26 Sep 2023 12:35:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] common: check user and group existence via id
Message-ID: <20230926-kursprogramm-halfen-9856aff95172@brauner>
References: <20230925-fstests-check-user-v1-1-09b97257bcdb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230925-fstests-check-user-v1-1-09b97257bcdb@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 25, 2023 at 05:22:21PM +0200, Christian Brauner wrote:
> Newer machines support the creation of users that don't appear in
> /etc/passwd but are only available via nss or userdbd. Use the id binary
> which is portable and reliable.
> 
> With this change I can run xfstests on systems where the users are
> created via systemd-userdbd drop-ins. See the documentation in [1] and [2].
> 
> Link: [1]: https://man7.org/linux/man-pages/man8/nss-systemd.8.html
> Link: [2]: https://man7.org/linux/man-pages/man5/nsswitch.conf.5.html
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

I need to resend a fixed version. I only send half the patch.
