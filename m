Return-Path: <eguan@redhat.com>
Date: Fri, 21 Nov 2014 12:44:03 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: mark replace tests in btrfs/group
Message-ID: <20141121044403.GE5834@dhcp-13-216.nay.redhat.com>
References: <546CB84B.8010200@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546CB84B.8010200@sandeen.net>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 19, 2014 at 09:33:31AM -0600, Eric Sandeen wrote:
> A couple tests exercise replace but were not marked as such
> in the group file.

Hi Eric,

I have a patch sitting in my git tree that adds most of btrfs tests in
one or more groups, I'll send it out for review soon.

Thanks,
Eryu
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 9adf862..1f23979 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -13,7 +13,7 @@
>  008 auto quick
>  009 auto quick
>  010 auto quick
> -011 auto
> +011 auto replace
>  012 auto
>  013 auto quick
>  014 auto
> @@ -22,7 +22,7 @@
>  017 auto quick
>  018 auto quick
>  019 auto quick
> -020 auto quick
> +020 auto quick replace
>  021 auto quick
>  022 auto
>  023 auto
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
