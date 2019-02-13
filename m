Received: from mail-yb1-f172.google.com ([209.85.219.172]:35961 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfBMTem (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Feb 2019 14:34:42 -0500
MIME-Version: 1.0
References: <CA+EzBbDyoPF8=mZyG8HQAoHTm4h4MSCe=5WX_SBqRwPej=4uFg@mail.gmail.com>
 <CAOQ4uxh7OayzbGFk0cxoZf_t9jGxesv9k6zPPOA=+5MDsqWOzA@mail.gmail.com>
 <CA+EzBbC5c-O0ZBuC+UaL7Ftp2Vh8K8d46_6HTBWetY2Otd=tiA@mail.gmail.com>
 <CAOQ4uxi=riQHbaaBxK64SdWdQ1bbHPrPTyXaoOrinG1zggK5gQ@mail.gmail.com> <CAHWVdUUQ4=jWJj3eJMyv54n3O3svT8S_BJM9E8gbY4UCc1Rwow@mail.gmail.com>
In-Reply-To: <CAHWVdUUQ4=jWJj3eJMyv54n3O3svT8S_BJM9E8gbY4UCc1Rwow@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Feb 2019 21:34:29 +0200
Message-ID: <CAOQ4uxh8n5ieuaeZ4jSUKJmUTf9QZtBVM8kRaBwGDuhtJbf64g@mail.gmail.com>
Subject: Re: Documenting the crash consistency guarantees of file systems
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Vijay Chidambaram <vijay@cs.utexas.edu>
Cc: Jayashree Mohan <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Filipe Manana <fdmanana@gmail.com>, Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 13, 2019 at 8:35 PM Vijay Chidambaram <vijay@cs.utexas.edu> wrote:
>
> On Wed, Feb 13, 2019 at 12:22 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Feb 13, 2019 at 7:06 PM Jayashree Mohan <jaya@cs.utexas.edu> wrote:
> > >
> > > Hi Amir!
> > >
> > > Thanks for putting across your thoughts on this. Your suggestions
> > > definitely make sense, and we'll compile these information and submit
> > > a patch for review.
> > >
> > > When it comes to strictly ordered metadata consistency, to the best of
> > > our knowledge only xfs claims to provide it explicitly. In ext4,
> > > delayed allocation and fsync of a file not persisting all its hard
> > > links[1] are examples of violation to the strictly ordered metadata
> > > consistency right?
> >
> > No, I don't think they are.
> > At least that is not how understand what Ted wrote.
> >
> > > And for btrfs, they don't seem to explicit about
> > > providing such semantics. Look at this thread[2] for example, owing to
> > > the lack of specification, btrfs does not commit to providing such
> > > guarantees.
> >
> > The discussion is not about ordered metadata, is it about what
> > fsync(file) should do. They are related if we decide that fsync(file)
> > should persist nlink, but I think all fs maintainers are in agreement
> > that it doesn't matter and btrfs choice is as valid as ext4/xfs choice.
> >
> > That said, I don't know if btrfs does strictly ordered metadata or not.
> > Order metadata means if user does op A then op B, you should not be
> > able to see consequence of op B after crash without seeing the
> > consequence of op A.
> >
> > Can you give a counter example for btrfs? for ext4?
>
> My understanding of strictly ordered metadata is that if op A precedes
> op B in program order (in-memory execution), then op A should precede
> op B in persistence order. As you say, one should not observe op B on
> storage without op A. Note that we don't say anything about whether
> fsync was called on op A or op B.
>
> I remember this old conversation from our ALICE work that btrfs does
> not persist things in order:
> https://www.spinics.net/lists/linux-btrfs/msg32215.html
>

Yap that seems to break strict ordering.

> If you do the following:
>
> create file foo
> write to file foo
> rename bar to baz
> CRASH
>
> and then you see baz but not foo on storage, that is a violation of
> strictly ordered semantics. ext4 violates this due to delayed
> allocation. So it does not provide strictly ordered metadata?
>

You are saying that you do not see foo dir entry on storage
or that you do not see foo data on storage. Two completely different
things. metadata ordering is not about data and delayed allocation
is mostly about data.

There are metadata changes that are implied by data changes
(mtime,ctime,size), but those are also deferred along with delayed
allocation.

So we need to rephrase/clarify.
I intentionally use the language "op A" and "op B" and I meant
that the rule only apply to "metadata ops" - now this is a term that
may be hard to define. Different filesystems may have different
views on what qualifies as a "metadata op".
No one will probably argue that rename() is not a metadata op,
but truncate/punch/clone, there may be some wiggle room for
interpretation (and that statement is likely to draw flames).

> AFAIK, any file system which persists things out of order to increase
> performance does not provide strictly ordered metadata semantics.
> These semantics seem to indicate a total ordering among all
> operations, and an fsync should persist all previous operations (as
> ext3 used to do).
>

fsync in xfs does not persist all previous operations.
It knows which is the last transaction where target inode was changed
and it only needs to flush transactions up this this one.

Thanks,
Amir.
