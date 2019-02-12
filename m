Received: from sandeen.net ([63.231.237.45]:33516 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbfBLS7H (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 12 Feb 2019 13:59:07 -0500
Subject: Re: [PATCH] Fix error message when xfs handle library not found
References: <20190212181840.7093-1-fdmanana@kernel.org>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <93a04478-db84-95f2-9957-5588dc0a54ed@sandeen.net>
Date: Tue, 12 Feb 2019 12:59:02 -0600
MIME-Version: 1.0
In-Reply-To: <20190212181840.7093-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2/12/19 12:18 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The error message mentions a "make install-lib" target from xfsprogs,
> however that target does not exists in xfsprogs, what exists is a
> target named "install-dev". So fix that and replace "install-lib" with
> "install-dev".
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  m4/package_xfslibs.m4 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/m4/package_xfslibs.m4 b/m4/package_xfslibs.m4
> index 9be56e11..ad019518 100644
> --- a/m4/package_xfslibs.m4
> +++ b/m4/package_xfslibs.m4
> @@ -83,7 +83,7 @@ AC_DEFUN([AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE],
>          echo
>          echo 'FATAL ERROR: could not find a current XFS handle library.'
>          echo 'Install or upgrade the XFS library package.'

To fix things up a bit more, I'd probably not refer to the "XFS library package"
because I'm not sure that exists anywhere either, does it?

In fedora/rhel land, it's in xfsprogs & xfsprogs-devel for development.

Not sure about suse or debian or ...?

Not a huge deal but if nobody ships xfsprogs-libs (or similar) then maybe best
to fix that line as well.

> -        echo 'Alternatively, run "make install-lib" from the xfsprogs source.'
> +        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'

and yeah, this part makes sense.

-Eric

>          exit 1
>      ])
>      libhdl="-lhandle"
> 
