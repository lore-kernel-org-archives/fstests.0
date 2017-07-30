Received: from mail-qt0-f196.google.com ([209.85.216.196]:36139 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdG3D1d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 29 Jul 2017 23:27:33 -0400
Received: by mail-qt0-f196.google.com with SMTP id c15so10472781qta.3
        for <fstests@vger.kernel.org>; Sat, 29 Jul 2017 20:27:32 -0700 (PDT)
Date: Sun, 30 Jul 2017 00:27:28 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: Re: [PATCH] generic/449: remove unused _require_test
Message-ID: <20170730032727.GA4836@debian.home>
References: <1500879458-3673-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500879458-3673-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 24, 2017 at 02:57:38PM +0800, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> -_require_test
>  _require_acls
>  _require_attrs

Hi, I wrote that test, thank you for taking the time to review it.

It would seem that _require_acls uses the test device, things could get
weird if it's not there.
