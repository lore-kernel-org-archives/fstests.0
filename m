Received: from tbjjbihbhebab.turbo-smtp.net ([199.187.174.101]:57260 "HELO
	tbjjbihbhebab.turbo-smtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751713AbbJERPN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 5 Oct 2015 13:15:13 -0400
Message-ID: <5612B01C.50600@sysam.it>
Date: Mon, 05 Oct 2015 19:15:08 +0200
From: Angelo Dureghello <angelo@sysam.it>
MIME-Version: 1.0
Subject: Re: help on xfs test results
References: <560C69D9.6020807@sysam.it> <560CF355.7050200@sysam.it> <20151001235653.GH3902@dastard> <560DD051.4080407@sandeen.net> <20151002003834.GI3902@dastard>
In-Reply-To: <20151002003834.GI3902@dastard>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Eric Sandeen <sandeen@sandeen.net>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hi Dave, Eric and all,

still thanks.

About generic/256 failing in my system,

in the xfstests README there is:

- create fsgqa test user ("sudo useradd fsgqa")

this creates the user, but in /etc/passwd comes "/bin/sh" as shell,
and in this system is it "dash". Redirection to /dev/null as required
from this test then fails. Setting to "/bin/bash" test passes.


About xfs/136,

ack, thanks.



On 02/10/2015 02:38, Dave Chinner wrote:
> On Thu, Oct 01, 2015 at 07:31:13PM -0500, Eric Sandeen wrote:
>>
>>
>> On 10/1/15 6:56 PM, Dave Chinner wrote:
>>> Are you testing with something like selinux or some other security
>>> subsystem enabled that creates attributes at inode creation time?
>>
>> In theory, xfstests detects this and mounts with an fs-wide context
>> to avoid that...
>
> For selinux, yes. i don't think it's aware of anything else,
> though...
>
> Cheers,
>
> Dave.
>


Best regards
Angelo

