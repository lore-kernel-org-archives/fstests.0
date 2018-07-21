Received: from mail-pf1-f194.google.com ([209.85.210.194]:40380 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeGUS16 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 Jul 2018 14:27:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so265288pff.7
        for <fstests@vger.kernel.org>; Sat, 21 Jul 2018 10:34:30 -0700 (PDT)
Date: Sun, 22 Jul 2018 01:31:16 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] Makefile: replace lowercase letters regex with POSIX
 character class
Message-ID: <20180721173116.GB2791@desktop>
References: <20180719100349.5968-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719100349.5968-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 19, 2018 at 06:03:49PM +0800, Zorro Lang wrote:
> Latest glibc changed some rules of sorting and regexes, the usage
> likes "[a-z]" maybe not only stand for lowcase letters a..z in
> different locale. Similar issues include [A-Z], [0-9] and so on.
> 
> For example, in en_US.UTF-8 locale, [a-z] means aAbBcCdD...zZ,
> it stands for both of uppercase and lowercase. Currently this
> issue cause `make install` fails on system with new glibc.
> 
> So use POSIX character class to instead of [...] group, something
> likes [:lower:], [:upper:], [:alpha:], [:alnum:], etc... are common.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

This looks fine to me, thanks for the fix!

Eryu

> ---
> 
> Hi,
> 
> I found that there're two lines in common/config:
> export LANG=C
> export LC_ALL=C
> 
> That can make sure that all cases can use [a-z], [A-Z], [0-9] ...
> as our expected. So we only need to fix this Makefile issue.
> Due to I only find this one issue, so I'd like to use [:lower:].
> 
> If you prefer set locale in Makefile, please tell me.
> 
> Thanks,
> Zorro
> 
>  tests/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile b/tests/Makefile
> index 11164e9e..8ce8f209 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -5,7 +5,7 @@
>  TOPDIR = ..
>  include $(TOPDIR)/include/builddefs
>  
> -TESTS_SUBDIRS = $(sort $(dir $(wildcard $(CURDIR)/[a-z]*/)))
> +TESTS_SUBDIRS = $(sort $(dir $(wildcard $(CURDIR)/[[:lower:]]*/)))
>  
>  include $(BUILDRULES)
>  
> -- 
> 2.14.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
