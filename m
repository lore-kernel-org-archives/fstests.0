Received: from mail-vk0-f44.google.com ([209.85.213.44]:32954 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdFWNaj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Jun 2017 09:30:39 -0400
Received: by mail-vk0-f44.google.com with SMTP id r126so5497461vkg.0
        for <fstests@vger.kernel.org>; Fri, 23 Jun 2017 06:30:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170512050922.GK7250@eguan.usersys.redhat.com>
References: <1494502507-27742-1-git-send-email-agruenba@redhat.com> <20170512050922.GK7250@eguan.usersys.redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 23 Jun 2017 15:30:38 +0200
Message-ID: <CAHc6FU6VbQM5UbHf=J5r_0_RYaM4WGE3Vjv0SFS+CojO9YT0nA@mail.gmail.com>
Subject: Re: [PATCH] src/seek_sanity_test: Fix for filesystems without
 unwritten extent support
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 12, 2017 at 7:09 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Thu, May 11, 2017 at 01:35:07PM +0200, Andreas Gruenbacher wrote:
>> src/seek_sanity_test (test generic/285) assumes that after preallocating
>> space in a file with fallocate, fseek SEEK_HOLE / SEEK_DATA will still
>> report the allocated space as a hole.  On filesystems without unwritten
>> extent support, that space will be reported as data, though.
>>
>> Tested on ext4, xfs, and gfs2 + patches for fseek SEEK_HOLE / SEEK_DATA
>> support.
>
> The idea seems fine to me, but I'm not that familiar with SEEK_DATA/HOLE
> support, it'd be great if someone else could help review this patch.
>
> Some of my thoughts inline.
>
>>
>> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>> ---
>>  src/seek_sanity_test.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
>> index a6dd48c..0d7fa0a 100644
>> --- a/src/seek_sanity_test.c
>> +++ b/src/seek_sanity_test.c
>> @@ -37,6 +37,7 @@
>>
>>  static blksize_t alloc_size;
>>  int default_behavior = 0;
>> +int unwritten_extents = 0;
>>  char *base_file_path;
>>
>>  static void get_file_system(int fd)
>> @@ -282,6 +283,11 @@ static int test09(int fd, int testnum)
>>       int bufsz = alloc_size;
>>       int filsz = 8 << 20;
>>
>> +     if (!unwritten_extents) {
>> +             fprintf(stdout, "Test skipped\n");
>> +             goto out;
>> +     }
>> +
>>       /*
>>        * HOLE - unwritten DATA in dirty page - HOLE -
>>        * unwritten DATA in writeback page
>> @@ -338,6 +344,11 @@ static int test08(int fd, int testnum)
>>       int bufsz = alloc_size;
>>       int filsz = 4 << 20;
>>
>> +     if (!unwritten_extents) {
>> +             fprintf(stdout, "Test skipped\n");
>> +             goto out;
>> +     }
>> +
>>       /* HOLE - unwritten DATA in writeback page */
>>       /* Each unit is bufsz */
>>       buf = do_malloc(bufsz);
>> @@ -387,6 +398,11 @@ static int test07(int fd, int testnum)
>>       int bufsz = alloc_size;
>>       int filsz = 4 << 20;
>>
>> +     if (!unwritten_extents) {
>> +             fprintf(stdout, "Test skipped\n");
>> +             goto out;
>> +     }
>> +
>>       /* HOLE - unwritten DATA in dirty page */
>>       /* Each unit is bufsz */
>>       buf = do_malloc(bufsz);
>> @@ -776,6 +792,25 @@ static int test_basic_support(void)
>>               fprintf(stderr, "File system supports the default behavior.\n");
>>       }
>>
>> +     ftruncate(fd, 0);
>> +     if (fallocate(fd, 0, 0, alloc_size) == -1) {
>> +             if (errno == EOPNOTSUPP) {
>> +                     fprintf(stderr, "File system does not support fallocate.");
>> +             } else {
>> +                     fprintf(stderr, "ERROR %d: Failed to preallocate "
>> +                             "space to %ld bytes.", errno, (long) alloc_size);
>> +             }
>
> Use do_fallocate here? It already did the EOPNOTSUPP check. And
> introduce another flag, e.g. prealloc, to save the fallocate support
> status? So that test0[7-9] don't have to do the EOPNOTSUPP check again.

In fact unwritten extent support implies fallocate support, so we can
get rid of the redundant checks for missing fallocate support.

>> +             fprintf(stderr, "  Skipping unwritten extent tests.\n");
>> +             goto out;
>> +     } else {
>> +             pos = lseek(fd, 0, SEEK_DATA);
>
> Hmm, it's hard to tell if it's a bug in lseek or the fs doesn't support
> unwritten extents, because we're going to test lseek SEEK_DATA/HOLE
> interface.
>
> How about using fiemap and check the FIEMAP_EXTENT_UNWRITTEN flag? Only
> falling back to lseek if fiemap is not supported?

Wouldn't this only complicate and open things up to fiemap bugs in addition?

I'll send an updated patch.

Thanks,
Andreas
