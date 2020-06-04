Return-Path: <SRS0=+7JN=7R=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82825C433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 08:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEE220738
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 08:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgFDIa1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:30:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:57446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgFDIa1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Jun 2020 04:30:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3D09AC96;
        Thu,  4 Jun 2020 08:30:28 +0000 (UTC)
Date:   Thu, 4 Jun 2020 10:30:23 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Yong Sun <sunyong0511@gmail.com>, Eric Sandeen <sandeen@redhat.com>
Cc:     fstests@vger.kernel.org, Yong Sun <yosun@suse.com>,
        Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] fstests: modify user name beginning with non-digit
Message-ID: <20200604083023.GA26629@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200603102035.552-1-yosun@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603102035.552-1-yosun@suse.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Sero,

> openSUSE and SLE don't support username begin with digit, so it will
> skip test generic/597 and generic/598 by lack of 123456-fsgqa user.
> generic/597 and 598 are not test username begin with digit on purpose
> (different with generic/381). It's will be helpful to use an username
> begin with non-digit in this case.

> Signed-off-by: Sun Yong <yosun@suse.com>
> ---
>  README            | 1 +
>  tests/generic/597 | 4 ++--
>  tests/generic/598 | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)

> diff --git a/README b/README
> index 094a7742..cffa0bc6 100644
> --- a/README
> +++ b/README
> @@ -22,6 +22,7 @@ _______________________
>  - create fsgqa test user ("sudo useradd -m fsgqa")
>  - create fsgqa group ("sudo groupadd fsgqa")
>  - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
I thought fsgqa-123456 is replacement for 123456-fsgqa. Thus I'd delete this
line.
> +- create fsgqa-123456 test user ("sudo useradd fsgqa-123456")

Also test tests/generic/381 still uses 123456-fsgqa. Shouldn't be replaced as
well?

>  ______________________
>  USING THE FSQA SUITE
> diff --git a/tests/generic/597 b/tests/generic/597
> index 1d87a23a..c4d524b7 100755
> --- a/tests/generic/597
> +++ b/tests/generic/597
> @@ -43,11 +43,11 @@ _require_sysctl_variable fs.protected_symlinks
>  _require_sysctl_variable fs.protected_hardlinks
>  # su in _require_user prints warnings about user name starts with a digit,
>  # discard the warning
> -_require_user 123456-fsgqa >/dev/null 2>&1
> +_require_user fsgqa-123456 >/dev/null 2>&1
I that redirection to /dev/null was due errors caused by starting with
digits. As other _require_user calls don't have it, I'd remove the
redirection. + remove that comment "su in _require_user prints warnings about
user name starts with a digit," ... which is now useless/invalid.

Eric, was there a reson to use user name which starts with digit?

>  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
>  _require_user fsgqa

> -OWNER=123456-fsgqa
> +OWNER=fsgqa-123456
>  OTHER=fsgqa

>  # Save current system state to reset when done
> diff --git a/tests/generic/598 b/tests/generic/598
> index 998b62cf..1cf9a3d1 100755
> --- a/tests/generic/598
> +++ b/tests/generic/598
> @@ -43,11 +43,11 @@ _require_sysctl_variable fs.protected_regular
>  _require_sysctl_variable fs.protected_fifos
>  # su in _require_user prints warnings about user name starts with a digit,
>  # discard the warning
> -_require_user 123456-fsgqa >/dev/null 2>&1
> +_require_user fsgqa-123456 >/dev/null 2>&1
>  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
>  _require_user fsgqa

> -USER1=123456-fsgqa
> +USER1=fsgqa-123456
>  USER2=fsgqa

>  # Save current system state to reset when done

Kind regards,
Petr
