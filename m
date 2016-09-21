Received: from sandeen.net ([63.231.237.45]:33044 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934016AbcIUOxB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Sep 2016 10:53:01 -0400
Subject: Re: [PATCH 2/3] modify xfs/ quota tests to work on generic
 filesystems
References: <65c03ebd-ee9c-7439-2642-0362a177ec6d@redhat.com>
 <ef6b5c28-9579-c13e-0547-17d05f150714@sandeen.net>
 <20160921093721.GK27776@eguan.usersys.redhat.com>
 <a9112b04-17a3-dbdc-7c19-b2490875b6fd@sandeen.net>
 <20160921143044.GL27776@eguan.usersys.redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <a2687ee1-c3d9-becf-9acf-4b58a53bbfc0@sandeen.net>
Date: Wed, 21 Sep 2016 09:52:59 -0500
MIME-Version: 1.0
In-Reply-To: <20160921143044.GL27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 9/21/16 9:30 AM, Eryu Guan wrote:
> On Wed, Sep 21, 2016 at 08:02:39AM -0500, Eric Sandeen wrote:
>>>>  #
>>>> +# checks that xfs_quota can operate on foreign (non-xfs) filesystems
>>>> +# Skips check on xfs filesystems, old xfs_quota is fine there.
>>>> +# Appends "-f" to enable foreign behavior on non-xfs filesystems if available.
>>>> +#
>>>> +_require_xfs_quota_foreign()
>>>> +{
>>>> +    if [ "$FSTYP" != "xfs" ]; then
>>>> +	$XFS_QUOTA_PROG -f -V &>/dev/null || \
>>>> +		_notrun "xfs_quota binary does not support foreign filesystems"
>>>> +	XFS_QUOTA_PROG="$XFS_QUOTA_PROG -f"
>>>> +    fi
>>>
>>> Mixing space and tab in this function.
>>
>> yep -
>>
>> As do the functions before and after it - are we going with a strict
>> rule now or going for consistency with the rest of the code?
> 
> I think currently the rule is that we use tab as indentions for new
> code, e.g. new functions, new tests, as long as the new code doesn't mix
> with existing code. And we only go for the consistency when modifying
> old code with spaces as indention.
> 
> I just searched for Dave's explanation, hope this explains better than
> my words :)
> 
>    - some of the code uses 4 space tabs. When adding code into
>      such functions, please use 4 space tabs. New code should
>      use 8 space tabs, but only if it's not surrounded by code
>      that is using 4 space tabs.

Ok, fair enough.  I still think it may be worth just re-tabbing everything,
most people modifying this stuff won't be looking for old emails, they'll
be looking at the current convention present in the code they are modifying.  :)

Thanks,
-Eric
