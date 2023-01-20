Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96D9C27C7C
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 17:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjATRSR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 12:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjATRSQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 12:18:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C91C79F8
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 09:17:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 79CCA5FB90;
        Fri, 20 Jan 2023 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674235072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pLwD7y7w6mkTwtitawTu42lG59GOYK7ig6T4hkz5H4=;
        b=YssJQdrSpugg7AvAIibGUMNyPYdykOhomDKFthV8LTVIvFRZgkquGy8Gi3wEk8atM/RJAH
        pvYGMTyQe3aXmeQPxJWB1dbHLk4sNaYUJwyDgkghbqE5a8HIovSCwCaSVbfQWyAPpLAG64
        Y6IVYlJj1gZ55GEXKiadXBaZX7lq9wE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674235072;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pLwD7y7w6mkTwtitawTu42lG59GOYK7ig6T4hkz5H4=;
        b=D6GWxwlfrM3TWrLEb+g3AH+BET1ACNRnkkqnAaYv783e0vPSLYCPug4A59SUUjOVcrRqYN
        sCXQsHeN+8WxICAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E69113251;
        Fri, 20 Jan 2023 17:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0weNFcDMymPwQQAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 20 Jan 2023 17:17:52 +0000
Date:   Fri, 20 Jan 2023 18:19:01 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Long An <lan@suse.com>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v4] btrfs/011: use $_btrfs_profile_configs to limit the
 tests
Message-ID: <20230120181901.5769b7f5@echidna.fritz.box>
In-Reply-To: <c49028312de0847b1b30328950403ca6a4437fb3.camel@suse.com>
References: <20230111131833.471ada43@echidna.fritz.box>
        <20230114031909.8294-1-lan@suse.com>
        <20230120124939.6441a073@echidna.fritz.box>
        <c49028312de0847b1b30328950403ca6a4437fb3.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

On Fri, 20 Jan 2023 15:59:02 +0000, Long An wrote:

...
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"-m dup -d dup -M:1 no 64" \ =20
> >=20
> > This dup/dup case no longer gets run with a default
> > _btrfs_profile_configs[]. Is that intentional?
> >=20
> > Cheers, David =20
>=20
> I thought profiles from "BTRFS_PROFILE_CONFIGS" should be fine. But
> this really changed=C2=A0behavior with default configs, and will get worse
> if use "_btrfs_profile_configs replace".
>=20
> In a brief, I just need a way to limit tests. If the default
> config=C2=A0is=C2=A0not=C2=A0
> suitable, how about using a new argument to
> "_btrfs_get_profile_configs"?

Yes, a new parameter for _btrfs_get_profile_configs() which adds the
missing "dup:dup" entry sounds reasonable.

Cheers, David
