Received: from mail-ig0-f179.google.com ([209.85.213.179]:35597 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbbJANgY (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 1 Oct 2015 09:36:24 -0400
Received: by igbkq10 with SMTP id kq10so15547022igb.0
        for <fstests@vger.kernel.org>; Thu, 01 Oct 2015 06:36:23 -0700 (PDT)
Subject: Re: [PATCH] properly quote strings tested with -n
References: <55E0E4AC.5050607@redhat.com> <560D3580.9000604@sandeen.net>
From: Alex Elder <elder@ieee.org>
Message-ID: <560D36D6.7000005@ieee.org>
Date: Thu, 1 Oct 2015 08:36:22 -0500
MIME-Version: 1.0
In-Reply-To: <560D3580.9000604@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <sandeen@redhat.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 10/01/2015 08:30 AM, Eric Sandeen wrote:
> Ping?

I no longer have your original message.  But this is
one I know and love (hate) from past experience with shell
scripting.  I eventually started always using "${FOO}"
in scripts to make sure I never had to chase down this
sort of bug, ever again.

I did not look at the whole set of fstests code
to see if you hit them all, but everything I see
here looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> On 8/28/15 5:46 PM, Eric Sandeen wrote:
>> Per the Advanced Bash Scripting Guide:
>>
>> "The -n test requires that the string be quoted within the test brackets.
>> Using an unquoted string with ! -z, or even just the unquoted string
>> alone within test bracket normally works, however, this is an unsafe
>> practice. Always quote a tested string."
>>
>> And indeed:
>>
>> $ unset FOOBAR
>> $ [ -n $FOOBAR ] || echo nope
>> $ [ -n "$FOOBAR" ] || echo nope
>> nope
>>
>> Ran into this on a box w/o the attr program installed, and passed
>> _require_attrs.  Quoting the string fixes this; fix it there
>> and other occurrences in common/* as well.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/common/attr b/common/attr
>> index 48c81cc..cc9cfda 100644
>> --- a/common/attr
>> +++ b/common/attr
>> @@ -165,7 +165,7 @@ _filter_aces_notypes()
>>  
>>  _require_acls()
>>  {
>> -    [ -n $CHACL_PROG ] || _notrun "chacl command not found"
>> +    [ -n "$CHACL_PROG" ] || _notrun "chacl command not found"
>>  
>>      #
>>      # Test if chacl is able to list ACLs on the target filesystems.  On really
>> @@ -196,9 +196,9 @@ _list_acl()
>>  
>>  _require_attrs()
>>  {
>> -    [ -n $ATTR_PROG ] || _notrun "attr command not found"
>> -    [ -n $GETFATTR_PROG ] || _notrun "getfattr command not found"
>> -    [ -n $SETFATTR_PROG ] || _notrun "setfattr command not found"
>> +    [ -n "$ATTR_PROG" ] || _notrun "attr command not found"
>> +    [ -n "$GETFATTR_PROG" ] || _notrun "getfattr command not found"
>> +    [ -n "$SETFATTR_PROG" ] || _notrun "setfattr command not found"
>>  
>>      #
>>      # Test if chacl is able to write an attribute on the target filesystems.
>> diff --git a/common/quota b/common/quota
>> index 23be4f8..658b1c3 100644
>> --- a/common/quota
>> +++ b/common/quota
>> @@ -26,7 +26,7 @@
>>  #
>>  _require_quota()
>>  {
>> -    [ -n $QUOTA_PROG ] || _notrun "Quota user tools not installed"
>> +    [ -n "$QUOTA_PROG" ] || _notrun "Quota user tools not installed"
>>  
>>      case $FSTYP in
>>      ext2|ext3|ext4|ext4dev|reiserfs)
>> @@ -74,7 +74,7 @@ _require_xfs_quota()
>>      if [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ]; then
>>  	_notrun "Quotas not supported on realtime scratch device"
>>      fi
>> -    [ -n $XFS_QUOTA_PROG ] || _notrun "XFS quota user tools not installed"
>> +    [ -n "$XFS_QUOTA_PROG" ] || _notrun "XFS quota user tools not installed"
>>  }
>>  
>>  #
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

