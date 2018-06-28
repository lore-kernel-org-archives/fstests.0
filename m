Received: from mail-yw0-f195.google.com ([209.85.161.195]:38468 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeF1EMj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Jun 2018 00:12:39 -0400
Received: by mail-yw0-f195.google.com with SMTP id w13-v6so1547725ywa.5
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 21:12:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627220759.GJ19934@dastard>
References: <20180627082103.9662-1-david@fromorbit.com> <20180627082103.9662-4-david@fromorbit.com>
 <CAOQ4uxj90rifsdgi67aMnqGzzX5P+oNQz_kRnpF73+wTjuq9kA@mail.gmail.com>
 <20180627142745.GH19934@dastard> <CAOQ4uxjhy1yiodyCJYnyYFmN2LOGLyeD41t_HD4rX5C0GTN1yA@mail.gmail.com>
 <20180627220759.GJ19934@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 Jun 2018 07:12:38 +0300
Message-ID: <CAOQ4uxjoHBzUFiXcWRcWX0E6RmQh+zhCty3Krrso4_hYDoQx3Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] shared: use new test setup preamble
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 28, 2018 at 1:07 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Jun 27, 2018 at 05:43:06PM +0300, Amir Goldstein wrote:
>> On Wed, Jun 27, 2018 at 5:27 PM, Dave Chinner <david@fromorbit.com> wrote:
>> > On Wed, Jun 27, 2018 at 01:56:29PM +0300, Amir Goldstein wrote:
>> >> On Wed, Jun 27, 2018 at 11:20 AM, Dave Chinner <david@fromorbit.com> wrote:
>> > Because the test is creating image files in $tmp, and we've had
>> > problems in the past with tests running the root filesystems out of
>> > space because they put too much shit in /tmp or dump crap in $here.
>> > TEST_DIR is supposed to be used at the work dir for things like this
>> > - we're trying to exercises the filesystem we are testing, not the
>> > root filesystem that hosts the fstests installation.
>> >
>>
>> I see. It might be better though to make this fix in a separate patch
>> and keeping the conversion patch to the minimal change I suggested.
>
> We can't make the conversion patch as you suggested because it's
> /doesn't fix the broken usage of $tmp/. That's the intent of this
> whole conversion - to fix these bugs by converting to common setup
> code. So we need to fix the bugs as we convert them, not slap a
> band-aid over them and then have to come back and fix them later (if
> we remember which of the many, many tests need fixing!).
>
> Again, lets not ake this conversion harder than it needs to be by
> trying to split hairs over how individual bugs are fixed. There are
> /hundreds of bugs/ that need to be fixed during this conversion
> - the cost of separating them out is prohibitive, and it makes no
> sense to add more change management time and overhead to an
> already resource intensive conversion process.
>

No worries. I'll stick to validating correctness in review.
I realize how agonizing this conversion task can be.

Cheers,
Amir.
