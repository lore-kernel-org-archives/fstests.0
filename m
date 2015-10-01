Received: from sandeen.net ([63.231.237.45]:54646 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756072AbbJANam (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 1 Oct 2015 09:30:42 -0400
Subject: Re: [PATCH] properly quote strings tested with -n
References: <55E0E4AC.5050607@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <560D3580.9000604@sandeen.net>
Date: Thu, 1 Oct 2015 08:30:40 -0500
MIME-Version: 1.0
In-Reply-To: <55E0E4AC.5050607@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Ping?

On 8/28/15 5:46 PM, Eric Sandeen wrote:
> Per the Advanced Bash Scripting Guide:
> 
> "The -n test requires that the string be quoted within the test brackets.
> Using an unquoted string with ! -z, or even just the unquoted string
> alone within test bracket normally works, however, this is an unsafe
> practice. Always quote a tested string."
> 
> And indeed:
> 
> $ unset FOOBAR
> $ [ -n $FOOBAR ] || echo nope
> $ [ -n "$FOOBAR" ] || echo nope
> nope
> 
> Ran into this on a box w/o the attr program installed, and passed
> _require_attrs.  Quoting the string fixes this; fix it there
> and other occurrences in common/* as well.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/common/attr b/common/attr
> index 48c81cc..cc9cfda 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -165,7 +165,7 @@ _filter_aces_notypes()
>  
>  _require_acls()
>  {
> -    [ -n $CHACL_PROG ] || _notrun "chacl command not found"
> +    [ -n "$CHACL_PROG" ] || _notrun "chacl command not found"
>  
>      #
>      # Test if chacl is able to list ACLs on the target filesystems.  On really
> @@ -196,9 +196,9 @@ _list_acl()
>  
>  _require_attrs()
>  {
> -    [ -n $ATTR_PROG ] || _notrun "attr command not found"
> -    [ -n $GETFATTR_PROG ] || _notrun "getfattr command not found"
> -    [ -n $SETFATTR_PROG ] || _notrun "setfattr command not found"
> +    [ -n "$ATTR_PROG" ] || _notrun "attr command not found"
> +    [ -n "$GETFATTR_PROG" ] || _notrun "getfattr command not found"
> +    [ -n "$SETFATTR_PROG" ] || _notrun "setfattr command not found"
>  
>      #
>      # Test if chacl is able to write an attribute on the target filesystems.
> diff --git a/common/quota b/common/quota
> index 23be4f8..658b1c3 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -26,7 +26,7 @@
>  #
>  _require_quota()
>  {
> -    [ -n $QUOTA_PROG ] || _notrun "Quota user tools not installed"
> +    [ -n "$QUOTA_PROG" ] || _notrun "Quota user tools not installed"
>  
>      case $FSTYP in
>      ext2|ext3|ext4|ext4dev|reiserfs)
> @@ -74,7 +74,7 @@ _require_xfs_quota()
>      if [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ]; then
>  	_notrun "Quotas not supported on realtime scratch device"
>      fi
> -    [ -n $XFS_QUOTA_PROG ] || _notrun "XFS quota user tools not installed"
> +    [ -n "$XFS_QUOTA_PROG" ] || _notrun "XFS quota user tools not installed"
>  }
>  
>  #
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
