Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145A8EB64D7
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jun 2023 12:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFUMko (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFUMkj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Jun 2023 08:40:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19C619A9
        for <fstests@vger.kernel.org>; Wed, 21 Jun 2023 05:40:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DFE42198F;
        Wed, 21 Jun 2023 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687351236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yi2QcPB9guGndpnC26iUL0Gwb7ncBn1ToZit8CNl/es=;
        b=0oXUYeEp8emu2HwIkqRB8GFPBEQPhbohlcPZYH8zNviiQZPoDvCP0+e+2EPQ166m5BtxbP
        zywWDbOH0m5luOc3KlnvBsm2EiXP5SK/33kORfdgzNtQV5ow8Oqg3t5kK2zy2c/f0MiKbS
        m4AztQfbE4fbwhm4qlwP7jAbxFxK+rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687351236;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yi2QcPB9guGndpnC26iUL0Gwb7ncBn1ToZit8CNl/es=;
        b=WpQuuIzhn1+O3z+PUcltOVN2rqJUfPvAOzJw6/2mMhr8840S7+ZsmJAqMdZmeGkYxtH+rT
        D8plu6iEjdNhs8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 639A0133E6;
        Wed, 21 Jun 2023 12:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fpC8FsTvkmSbUAAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 21 Jun 2023 12:40:36 +0000
Date:   Wed, 21 Jun 2023 14:42:52 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zorro Lang <zlang@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: reduce runtime of check -n
Message-ID: <20230621144252.2c3b5e7f@echidna.fritz.box>
In-Reply-To: <CAOQ4uxiwS8GZkgr6KYx9_+uCgv2Z11pdWxV3Qr6tu9cNP_Pwyw@mail.gmail.com>
References: <20230619105058.2711467-1-amir73il@gmail.com>
        <20230621022355.yk7dy2e6sghcuzrp@zlang-mailbox>
        <20230621112656.2efac042@echidna.fritz.box>
        <CAOQ4uxiwS8GZkgr6KYx9_+uCgv2Z11pdWxV3Qr6tu9cNP_Pwyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, 21 Jun 2023 15:09:35 +0300, Amir Goldstein wrote:

> On Wed, Jun 21, 2023 at 12:24=E2=80=AFPM David Disseldorp <ddiss@suse.de>=
 wrote:
...
> > > Actually I'm not sure what's this line for. We get $list by "cd $SRC_=
DIR; echo $1",
> > > is there any chance to have "$SRC_DIR" in $t (or $test_dir) ? =20
> >
> > Indeed, this line can be dropped. One minor change in behaviour here is
> > that a test pattern with a wacky path prefix e.g. ../tests/xfs/00? will
> > no longer work. I think breaking such patterns is okay, but it could
> > also be resolved by more carefully extracting the last two path
> > components.
> > =20
>=20
> I didn't want to drop it because I didn't want to change legacy behavior.
> When user's cwd is fstests root directory, it may be natural for some
> users to use bash auto completion to run the command
> ./check tests/generic/001
>=20
> so there may well be users out these that pass test names including
> the tests/ prefix and check has always trimmed this prefix.

Ah, yes, understood.

> There is something a bit confusing about expanding of bash
> patterns:
>=20
> When the user uses this syntax:
> ./check tests/generic/00?
>=20
> the shell expands that pattern to a list of 9 arguments passed to
> ./check tests/generic/001  tests/generic/002 ...
>=20
> But when the user uses the documented syntax:
> ./check generic/00?
> check gets a single argument and $(cd $SRC_DIR; echo $1)
> expands this single argument to a list
>=20
> All the above is existing behavior which my patch should
> not have changed.

The example I gave was "../tests/xfs/00?", which does get broken by this
change. It's relative to SRC_DIR and independent of check parameter
expansion. As mentioned, I think it's obscure enough usage that this
breakage shouldn't be worth bothering about.

Cheers, David
