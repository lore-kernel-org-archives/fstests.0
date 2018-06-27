Received: from mail-yw0-f194.google.com ([209.85.161.194]:35432 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964862AbeF0OsF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 10:48:05 -0400
Received: by mail-yw0-f194.google.com with SMTP id t18-v6so793173ywg.2
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 07:48:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627143413.GI19934@dastard>
References: <20180627082103.9662-1-david@fromorbit.com> <20180627082103.9662-6-david@fromorbit.com>
 <CAOQ4uxi7NP-NpK38CnBB=epxhq6Ykt+V-hSwOtAJuac7Gwt3og@mail.gmail.com> <20180627143413.GI19934@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Jun 2018 17:48:04 +0300
Message-ID: <CAOQ4uxiF473qHyGyJQYOv2zkse7qQAJBHrt5K_CkNxg=eqrKTg@mail.gmail.com>
Subject: Re: [PATCH 5/8] btrfs: convert some tests to new setup preamble
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 5:34 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Jun 27, 2018 at 02:30:13PM +0300, Amir Goldstein wrote:
>> On Wed, Jun 27, 2018 at 11:21 AM, Dave Chinner <david@fromorbit.com> wrote:
>> > From: Dave Chinner <dchinner@redhat.com>
>> >
>> > Small initial batch to demonstrate conversion.
>> >
>> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
>> > ---
>> [...]
>> > diff --git a/tests/btrfs/007 b/tests/btrfs/007
>> > index 09f2f011bc77..50ead03acf31 100755
>> > --- a/tests/btrfs/007
>> > +++ b/tests/btrfs/007
>> > @@ -9,37 +9,23 @@
>> >  # (incr) and send both snapshots to a temp file. Remake the file
>> >  # system and receive from the files. Check both states with fssum.
>> >  #
>> > -# creator
>> > -owner=list.btrfs@jan-o-sch.net
>> > +. common/setup_test
>> >
>> > -seq=`basename $0`
>> > -seqres=$RESULT_DIR/$seq
>> > -echo "QA output created by $seq"
>> > +# test exit cleanup goes here
>> > +cleanup() { :; }
>> >
>> > -tmp=`mktemp -d`
>> > -status=1
>> > -
>> > -_cleanup()
>> > -{
>> > -       echo "*** unmount"
>> > -       _scratch_unmount 2>/dev/null
>> > -       rm -f $tmp.*
>> > -}
>>
>> Bug in existing test - it does not cleanup $tmp.
>
> Yup, because it creates a non-standard $tmp but then uses code that
> assumes that tmp is the standard name prefix definition, not a
> directory.  This is exactly the sort of bug I'm trying to eradicate.
>
> And, FWIW, because the test is only using tmp files, it doesn't need
> to use TEST_DIR to store them so no need for a working directory to
> be defined.
>
>> cleanup() { rm -rf $tmp }
>>
>> -tmp=`mktemp -d`
>> +mkdir -p $tmp
>
> Again, no. $tmp is not a directory and there's infrastructure that
> assumes it is not a directory.
>

Ok, I see the logic in that argument.
16 more mktemp tests to go...

Thanks,
Amir.
