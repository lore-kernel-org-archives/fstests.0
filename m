Received: from mail-pl1-f194.google.com ([209.85.214.194]:39818 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfFGQI5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jun 2019 12:08:57 -0400
Date: Sat, 8 Jun 2019 00:08:52 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 1/2] common/casefold: Add infrastructure to test
 filename casefold feature
Message-ID: <20190607160852.GU15846@desktop>
References: <20190606193138.25852-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606193138.25852-1-krisman@collabora.com>
Sender: fstests-owner@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: tytso@mit.edu, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 06, 2019 at 03:31:37PM -0400, Gabriel Krisman Bertazi wrote:
> Add a set of basic helper functions to simplify the testing of
> casefolding capable filesystems.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  common/casefold | 108 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 common/casefold
> 
> diff --git a/common/casefold b/common/casefold
> new file mode 100644
> index 000000000000..34c1d4ae1af1
> --- /dev/null
> +++ b/common/casefold
> @@ -0,0 +1,108 @@
> +#-----------------------------------------------------------------------
> +#
> +# Common functions for testing filename casefold feature
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018 Collabora, Ltd.  All Rights Reserved.
                   ^^^^ 2019?
> +#
> +# Author: Gabriel Krisman Bertazi <krisman@collabora.com>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------

Please use the SPDX tags to specify licence, you could take common/rc as
a reference.

> +
> +_has_casefold_feature_kernel_support() {

The name seems a bit long to me, just _has_casefold_kernel_support()?

> +    case $FSTYP in
> +	ext4)
> +	    test -f '/sys/fs/ext4/features/casefold'
> +	    ;;
> +	*)
> +	    # defaults to unsupported
> +	    false
> +	    ;;
> +    esac

Please use 8-spaces tab for indention. The same for the new test.

> +}
> +
> +_require_casefold_support() {

_require_scratch_casefold(), as the function test casefold support
against scratch device, so add "scratch" in the function name to
indicate that.

> +    if ! _has_casefold_feature_kernel_support ; then
> +	_notrun "$FSTYP does not support casefold feature"
> +    fi
> +
> +    if ! _scratch_mkfs_casefold &>>seqres.full; then
> +	_notrun "$FSTYP userspace tools do not support casefold"
> +    fi
> +
> +    # Make sure the kernel can mount a filesystem with the encoding
> +    # defined by the userspace tools.  This will fail if
> +    # the userspace tool used a more recent encoding than the one
> +    # supported in kernel space.
> +    if ! _try_scratch_mount &>>seqres.full; then
> +	_notrun \
> +	    "kernel can't mount filesystem using the encoding set by userspace"
> +    fi
> +    _scratch_unmount
> +}
> +
> +_scratch_mkfs_casefold () {
> +    case $FSTYP in
> +	ext4)
> +	    _scratch_mkfs -O casefold $*
> +	    ;;
> +	*)
> +	    _notrun "Don't know how to mkfs with casefold support on $FSTYP"
> +	    ;;
> +	esac
> +}
> +
> +_scratch_mkfs_casefold_strict () {
> +    case $FSTYP in
> +	ext4)
> +	    _scratch_mkfs -O casefold -E encoding_flags=strict
> +	    ;;
> +	*)
> +	    _notrun \
> +		"Don't know how to mkfs with casefold-strict support on $FSTYP"
> +	    ;;
> +	esac
> +}
> +
> +_casefold_check_exact_name () {
> +    # To get the exact disk name, we need some method that does a
> +    # getdents() on the parent directory, such that we don't get
> +    # normalized/casefolded results.  'Find' works ok.

I think these could go before the helper.

> +    basedir=$1
> +    exact_name=$2

Declare local variables as "local", the same for all other local
variables, both in this casefold file and in the new test.

> +    find ${basedir} | grep -q ${exact_name}
> +}
> +
> +_try_set_casefold_attr () {
> +    chattr +F "${1}" &>/dev/null

$CHATTR_PROG

And need to require chattr in _require_scratch_casefold() too, e.g.

	_require_command "$CHATTR_PROG" chattr
> +}
> +
> +_try_unset_casefold_attr () {
> +    chattr -F "${1}" &>/dev/null

Same here. And I don't think we should redirect chattr output in these
helper functions, just let callers handle the outputs.

> +}
> +
> +_set_casefold_attr () {
> +    _try_set_casefold_attr "${1}" || \
> +	_fail "Unable to set casefold attribute on ${1}"
> +}
> +
> +_unset_casefold_attr () {
> +    _try_unset_casefold_attr "${1}" || \
> +	_fail "Unable to unset casefold attribute on ${1}"
> +}

And no need to _fail here. IMHO, just two helpers like:

_set_casefold_attr()
{
	$CHATTR_PROG +F "${1}"
}

_unset_casefold_attr()
{
	$CHATTR_PROG -F "${1}"
}

And let callers deal with the outputs/results. More comments on this in
next patch.

> +
> +_is_casefolded_dir () {
> +    lsattr -ld "${1}" | grep -q "Casefold"
> +}

$LSATTR_PROG, and do 

	_require_command "$LSATTR_PROG" lsattr

in _require_scratch_casefold() as well.

Thanks,
Eryu
> -- 
> 2.20.1
> 
