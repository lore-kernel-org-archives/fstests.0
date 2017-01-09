Received: from mail-oi0-f53.google.com ([209.85.218.53]:36664 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964928AbdAIKqY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Jan 2017 05:46:24 -0500
Received: by mail-oi0-f53.google.com with SMTP id u143so94189733oif.3
        for <fstests@vger.kernel.org>; Mon, 09 Jan 2017 02:46:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170109101717.GD1859@eguan.usersys.redhat.com>
References: <20170106034507.5915-1-eguan@redhat.com> <20170107045731.GC575@zzz>
 <20170109101717.GD1859@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 9 Jan 2017 12:46:23 +0200
Message-ID: <CAOQ4uxjqYFxCedvvYo8=YgoXDCPXogozAuVGd842sJLGQ9ipFQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: cleanup tmp files in tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Eric Biggers <ebiggers3@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 9, 2017 at 12:17 PM, Eryu Guan <eguan@redhat.com> wrote:
> Hi Eric and Amir,
>
> On Fri, Jan 06, 2017 at 08:57:31PM -0800, Eric Biggers wrote:
>> Hi Eryu,
>>
>> On Fri, Jan 06, 2017 at 11:45:07AM +0800, Eryu Guan wrote:
>> > $tmp.* files should be removed in _cleanup() even if the test is not
>> > using any $tmp.* file explicitly, because common helper functions
>> > may take use of them too.
>> >
>> > So cleanup tmp files properly in tests, and add a _cleanup()
>> > function and trap it on exit if the test doesn't do so, to make all
>> > tests consistent on the way they do cleanup.
>> >
>> > Also remove other tmp files used by the tests and the harness so
>> > that we leave no new tmp files in /tmp dir after a full test run.
>> >
>>
>> Why exactly can't the boilerplate go in a preamble file which is sourced by all
>> the tests?  For example common/preamble containing something like:
>
> Thanks for your review! As you two are basically suggesting the same
> solution, so I reply to you together.
>
> I agree that we can do a common/preamble for all tests to source, but I
> don't think we need to do that and it's not worth the effort.
>
> IMO, we define and setup the tests in the tests themselves, not in a
> common/preamble file, which makes the tests clear and easy to read. We
> don't want to "hide" any setups in a common file and to be a "surprise"
> to the reader, we don't have to look around for a certain setup.
>

The motivation for your work is the fact that tmp files are being created
in a way that is "hidden" from the test author  and therefore, IMO,
the cleanup of those temp files should also be in a common function
that is "hidden" from the test author.

> Also, all the common setup code are all in "new" script, the template is
> created automatically, and I fixed all other problematic tests once in
> this patch, we don't have any extra maintain burden, as long as all new
> tests are created by "new" script.
>
> And fstests has been this way for a very long time if not from the
> beginning. All the "old" users are familiar with this code style.

I relate to this argument very much and if something works and doesn't
both anyone, I believe we should let it be.

OTOH, this is the second tests wide change to _cleanup() that
I remember from recent times, the first having to do with cd /.
So IMO, _cleanup() should be made a generic function in common/cleanup
and those test that wish to override it should use the syntax:

       seq=`basename $0`
       seqres=$RESULT_DIR/$seq
       echo "QA output created by $seq"

       . ./common/cleanup

       my_cleanup()
       {
               # do my cleanup... and call generic cleanup
               generic_cleanup
       }

       here=`pwd`
       tmp=/tmp/$$
       status=1        # failure is the default!
       trap "my_cleanup; exit \$status" 0 1 2 3 15

       . ./common/rc

You don't even have to go over all the old tests and change them,
but at least for the test for which you need to add rm -f $tmp.*
just add a common _cleanup function and call it instead.
The end result would be much nicer, IMO.

> Converting to preamble file doesn't seem gain us more, it doesn't seem
> worth the effort converting all existing 900+ tests to new style. And if
> we only source common/preamble in new tests, we result in inconsistency
> across tests.
>
> But I'd like to see what other fstests users think on this.
>
> Thanks,
> Eryu
>
>>
>>       seq=`basename $0`
>>       seqres=$RESULT_DIR/$seq
>>       echo "QA output created by $seq"
>>
>>       _cleanup()
>>       {
>>               cd /
>>               rm -f $tmp.*
>>       }
>>
>>       here=`pwd`
>>       tmp=/tmp/$$
>>       status=1        # failure is the default!
>>       trap "_cleanup; exit \$status" 0 1 2 3 15
>>
>>       . ./common/rc
>>
>> Tests that need to do more cleanup could override the default trap.
>>
>> Eric
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
