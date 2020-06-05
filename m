Return-Path: <SRS0=y1X6=7S=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92075C433E0
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Jun 2020 06:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74022207D5
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Jun 2020 06:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFEGk4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:40:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:53714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgFEGk4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 Jun 2020 02:40:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62916AAD0;
        Fri,  5 Jun 2020 06:40:58 +0000 (UTC)
Date:   Fri, 5 Jun 2020 08:40:53 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Yong Sun <sunyong0511@gmail.com>
Cc:     fstests@vger.kernel.org, Yong Sun <yosun@suse.com>,
        sandeen@sandeen.net
Subject: Re: [PATCH v3] fstests: modify user name beginning with non-digit
Message-ID: <20200605064053.GA8912@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200605031236.7529-1-yosun@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605031236.7529-1-yosun@suse.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Sero,

> openSUSE and SLE don't support username begin with digit, so it will
> skip test generic/597 and generic/598 by lack of 123456-fsgqa user.
> generic/597 and 598 are not test username begin with digit on purpose
> (different with generic/381). It's will be helpful to use an username
nit: "It's will": maybe typo, do you mean "it would be"?

> begin with non-digit in this case.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +++ b/tests/generic/597
> @@ -41,13 +41,11 @@ _supported_os Linux
>  _require_test
>  _require_sysctl_variable fs.protected_symlinks
>  _require_sysctl_variable fs.protected_hardlinks
> -# su in _require_user prints warnings about user name starts with a digit,
> -# discard the warning
> -_require_user 123456-fsgqa >/dev/null 2>&1
> +_require_user fsgqa2
>  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
>  _require_user fsgqa
> -OWNER=123456-fsgqa
> +OWNER=fsgqa2
>  OTHER=fsgqa

BTW fsgqa is default parameter for _require_user, it wouldn't have to be
specified on second call, but that's not important, I'd personally reduce
duplicity a bit, but up to you (tiny detail, current patch is perfectly ok):

* tests/generic/598

USER1=fsgqa2
USER2=fsgqa

_require_user $USER1
# Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
_require_user $USER2

* tests/generic/597

OWNER=fsgqa2
OTHER=fsgqa

_require_user $OWNER
# Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
_require_user $OTHER

Kind regards,
Petr
