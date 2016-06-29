Received: from mail-wm0-f54.google.com ([74.125.82.54]:35614 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbcF2G10 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2016 02:27:26 -0400
Received: by mail-wm0-f54.google.com with SMTP id v199so166038511wmv.0
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2016 23:27:25 -0700 (PDT)
Subject: Re: [PATCH v2] generic/294: filter quotes from mknod
References: <1467032008-16374-1-git-send-email-omzg@plexistor.com>
 <20160629061529.GT27480@dastard>
From: Omer Zilberberg <omzg@plexistor.com>
Message-ID: <8843b27a-c8be-d6f8-ec47-b80f3c7e0a08@plexistor.com>
Date: Wed, 29 Jun 2016 09:27:21 +0300
MIME-Version: 1.0
In-Reply-To: <20160629061529.GT27480@dastard>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 06/29/2016 09:15 AM, Dave Chinner wrote:
> On Mon, Jun 27, 2016 at 03:53:28PM +0300, Omer Zilberberg wrote:
>> Since coreutils v8.25, mknod errors omit quotes around filenames, and
>> this breaks generic/294's golden image.
>>
>> Checked on Ubuntu 16.04.
>>
>> See coreutils: 08e8fd7 all: avoid quoting file names when possible
>> https://github.com/coreutils/coreutils/commit/08e8fd7e38f2dae7c69c54eb22d508b6517e66e5
>>
>> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
>>
>> v2: added comment to _filter_mknod.
>> ---
>>  common/filter         | 7 +++++++
>>  tests/generic/294     | 2 +-
>>  tests/generic/294.out | 2 +-
>>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> $ git grep -l mknod common/ tests/
> common/dmflakey
> common/populate
> tests/btrfs/004
> tests/generic/062
> tests/generic/085
> tests/generic/117
> tests/generic/157
> tests/generic/158
> tests/generic/184
> tests/generic/294
> tests/generic/294.out
> tests/generic/306
> tests/overlay/003
> tests/xfs/106
> $
> 
> Do any of these other tests that call mknod need this filtering?
To the best of my understanding, no.
The coreutils patch affects formatting of mknod error messages,
and these all begin with "mknod:". As you can see in your grep above,
only generic/294 has "mknod" in its expected output.
All others do not expect mknod failure messages, so do not require filtering.
> 
> Cheers,
> 
> Dave.
> 
Thanks
