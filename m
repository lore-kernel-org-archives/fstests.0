Received: from sandeen.net ([63.231.237.45]:41584 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbdG0NhI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 27 Jul 2017 09:37:08 -0400
Subject: Re: [PATCH] xfs: test xfs_metadump for leaked strings
References: <f96cbce4-faf0-6a30-508b-39e5d2c17f8b@redhat.com>
 <20170727105205.GD9167@eguan.usersys.redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <430e5852-bf79-cf8f-0f12-28cce1a32965@sandeen.net>
Date: Thu, 27 Jul 2017 08:37:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170727105205.GD9167@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 7/27/17 5:52 AM, Eryu Guan wrote:
> On Wed, Jul 26, 2017 at 03:33:20PM -0500, Eric Sandeen wrote:
>> xfs_metadump by default sanitizes the image so that all strings
>> longer than 5 chars are obfusccated, and all stale data in metadata
>> blocks (i.e. unused/unwritten data) is zeroed out.  We didn't have
>> a test for this, though, so this does it.
>>
>> It patterns 256M of the scratch device, then uses djwong's
>> populate infrastructure to write all types of metadata,
>> metadumps & mdrestores it, then looks for either the leaked
>> pre-pattern or any leaked strings or filenames.
>>
>> The strings we look for are, unfortunately, a bit ad-hoc based on
>> what is currently used in the populate routines.
> 
> I don't have a better idea to avoid this either..
> 
> Some minor issues below.

comment typo: will fix
whitespace: sigh, will fix ;)
groups: a patch to new script to check for this might be nice ;) will fix.
out file: Argh, always forget to add that to git

will resend, thanks.

-Eric
