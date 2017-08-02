Received: from sandeen.net ([63.231.237.45]:50000 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751696AbdHBDnp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Aug 2017 23:43:45 -0400
Subject: Re: [PATCH V2] xfs: test xfs_metadump for leaked strings
From: Eric Sandeen <sandeen@sandeen.net>
References: <f96cbce4-faf0-6a30-508b-39e5d2c17f8b@redhat.com>
 <4e801980-9ea5-efaf-f45c-d98df8f1f7e3@sandeen.net>
Message-ID: <3088c26b-7a53-84f4-39cb-c1d8664512d0@sandeen.net>
Date: Tue, 1 Aug 2017 22:43:44 -0500
MIME-Version: 1.0
In-Reply-To: <4e801980-9ea5-efaf-f45c-d98df8f1f7e3@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 8/1/17 9:58 PM, Eric Sandeen wrote:
> xfs_metadump by default sanitizes the image so that all strings
> longer than 5 chars are obfusccated, and all stale data in metadata
> blocks (i.e. unused/unwritten data) is zeroed out.  We didn't have
> a test for this, though, so this does it.
> 
> It patterns 256M of the scratch device, then uses djwong's
> populate infrastructure to write all types of metadata,
> metadumps & mdrestores it, then looks for either the leaked
> pre-pattern or any leaked strings or filenames.
> 
> The strings we look for are, unfortunately, a bit ad-hoc based on
> what is currently used in the populate routines.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Sigh, debugging junk snuck into this one, hang on for v3, sorry.  :(
