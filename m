Received: from mail-ot0-f193.google.com ([74.125.82.193]:33945 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbdAaCof (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2017 21:44:35 -0500
Received: by mail-ot0-f193.google.com with SMTP id 73so40467485otj.1
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2017 18:44:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484125203-12175-1-git-send-email-amir73il@gmail.com>
References: <1484125203-12175-1-git-send-email-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 31 Jan 2017 04:44:34 +0200
Message-ID: <CAOQ4uxgk-n91qs6MYovWiq38KVe0Th4Lj2D-mE9A5bN8H6MNRw@mail.gmail.com>
Subject: Re: [PATCH] Support xfstest -x group command line option
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

ping

On Wed, Jan 11, 2017 at 11:00 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> Note that while kvm-xfstests -X <test> is NOT equivalent to
> the check -X command line option, kvm-xfstests -x <group> is
> exactly the same as check -x <group>.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  kvm-xfstests/util/parse_cli | 4 ++++
>  1 file changed, 4 insertions(+)
>
> Also via github pull request:
> https://github.com/tytso/xfstests-bld/pull/3
>
> diff --git a/kvm-xfstests/util/parse_cli b/kvm-xfstests/util/parse_cli
> index b42c8ba..0956ebb 100644
> --- a/kvm-xfstests/util/parse_cli
> +++ b/kvm-xfstests/util/parse_cli
> @@ -26,6 +26,7 @@ print_help ()
>      fi
>      echo "     -o opts         - Extra kernel command line options"
>      echo "     -r ram          - Specify memory to be used in megabytes"
> +    echo "     -x group        - Exclude group of tests from running"
>      echo "     -X test         - Exclude test from running"
>      echo "     --kernel file   - Boot the specified kernel"
>      if test "$GCE_XFSTESTS" != "yes" ; then
> @@ -155,6 +156,9 @@ while [ "$1" != "" ]; do
>         -g) shift
>             FSTESTSET="$FSTESTSET,-g,$1"
>             ;;
> +       -x) shift
> +           FSTESTSET="$FSTESTSET,-x,$1"
> +           ;;
>         -h|--help|help)
>             print_help
>             ;;
> --
> 2.7.4
>
