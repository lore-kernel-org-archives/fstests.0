Received: from mail-qk1-f194.google.com ([209.85.222.194]:41184 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKMYw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Sep 2018 08:24:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id h138-v6so16132568qke.8
        for <fstests@vger.kernel.org>; Tue, 11 Sep 2018 00:26:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180911070244.GA13711@infradead.org>
References: <20180911052806.1302-1-lsahlber@redhat.com> <20180911052806.1302-2-lsahlber@redhat.com>
 <20180911070244.GA13711@infradead.org>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Tue, 11 Sep 2018 17:26:53 +1000
Message-ID: <CAN05THQ8c=wHW4i7qY6wMJw+XpMUtuB2Sk8b8-bzfYGnHimucg@mail.gmail.com>
Subject: Re: [PATCH] cloner: add support for clone_file_range for cifs
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 11, 2018 at 5:02 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Sep 11, 2018 at 03:28:06PM +1000, Ronnie Sahlberg wrote:
>> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
>> ---
>>  src/cloner.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/cloner.c b/src/cloner.c
>> index ffad82f0..9f9156e5 100644
>> --- a/src/cloner.c
>> +++ b/src/cloner.c
>> @@ -120,6 +120,18 @@ clone_file_range_btrfs(int src_fd, int dst_fd, uint64_t src_off,
>>  }
>>
>>  static int
>> +clone_file_range_cifs(int fd_in, int fd_out, loff_t off_in,
>> +                   loff_t off_out, size_t len)
>> +{
>> +     int ret;
>> +
>> +     ret = copy_file_range(fd_in, &off_in, fd_out, &off_out, len, 0);
>> +     if (ret < 0)
>> +             ret = errno;
>> +     return 0;
>> +}
>
> This is weird.  cloner seems to test clone, in which case it should
> test FICLONE (BTRFS_IOC_CLONE) / FICLONERANGE(BTRFS_IOC_CLONE_RANGE).
>
> But it seems to check file system magic numbers which is rather bogus
> to start with.  I think the right fix here is to remove all the magic
> number checks, always try FICLONE, and also remove support for the
> odd legacy cifs ioctl.

Thanks.  That is a lot bigger change but it is the right thing to do.

Please disregard this patch and I will make a new patch with your suggestions.

>
>>  {
>> @@ -128,7 +140,9 @@ clone_file_range(unsigned int fs_type, int src_fd, int dst_fd, uint64_t src_off,
>>               return clone_file_range_btrfs(src_fd, dst_fd, src_off, dst_off,
>>                                             len);
>>               break;
>> -     case CIFS_MAGIC_NUMBER: /* only supports full file server-side copies */
>> +     case CIFS_MAGIC_NUMBER:
>> +             return clone_file_range_cifs(src_fd, dst_fd, src_off, dst_off,
>> +                                          len);
>>       default:
>>               return ENOTSUP;
>>               break;
>
> And independent break after a return is just insane.  Someone needs
> to fix this program to stop the eye bleeding..
