Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C70DF72
	for <fstests@vger.kernel.org>; Tue,  7 Nov 2023 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5+9tl5H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E72133
	for <fstests@vger.kernel.org>; Tue,  7 Nov 2023 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699370004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1W9taJqRf4d+dEA6BQYQVEnq1UVM+85p7aR0E94A+ik=;
	b=L5+9tl5HVU0vukrt6B7SlDyWHEebhmUTiSIKoFsm78bVBhJCINI2ZSTICU1DQgEIpjBx/I
	6YXwEnkMoSWPoFVHS6IDfszgyZQ0Zy/KJ2WnCFy3lsumxrwcPUBGEi1C8D5XUbJSsVCwFK
	orOn2vAK1zJSVhw+xvhuLtbMaGL2chA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-uX2ShmndMvSOE5HkQ0vWvQ-1; Tue, 07 Nov 2023 10:13:20 -0500
X-MC-Unique: uX2ShmndMvSOE5HkQ0vWvQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6c334d2fd40so5334021b3a.2
        for <fstests@vger.kernel.org>; Tue, 07 Nov 2023 07:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370000; x=1699974800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1W9taJqRf4d+dEA6BQYQVEnq1UVM+85p7aR0E94A+ik=;
        b=rJFEZcHoQuQ6EWlCxlyXQ/l4HkpL+EKOZDZsGETeN+dmS3rwCB/of9rwh1lUGH6YJW
         X1f+xg7oN5W7jEJtd2u6VeaNoakJioIRfAPPFbXralyJv0P70MAIAa12hXFBg7c2/zHI
         1g/QpWhxZgw1b41ZRzeNHoo66gPAB9STFOcI0x8/e2wdCKxjMKK9BTI1oOw4sLKN9XO+
         rfQ5akOLuegOHvSVg1vfscHrZpxeZU3KcGRS+hRYyOpk/E8RW/TClgIbkdz5FXxqy24g
         VxZe+Vm628vW0eEmH8PjFaS/2+P52YzLjNM6+hmABdeLrQrioAdcPTlDld33K3VHYd8m
         fW9Q==
X-Gm-Message-State: AOJu0Yx2MrGYuUDkheBXndJQ7jVPptUU+5XIr1OI/+iJmbErYZdcLfdV
	voyG3Phcr+3oJs07yEyMe4NQBG1OP/noa2303vtJM6RCGmnGznavmn2/pxqv54rTXrCxirQP0TD
	yBur/+04pS7eRt0ZcbQ==
X-Received: by 2002:a05:6a20:6a05:b0:174:c134:81fa with SMTP id p5-20020a056a206a0500b00174c13481famr37890557pzk.17.1699369999566;
        Tue, 07 Nov 2023 07:13:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe+amVIotDXsV4wk1BWBstgblBqyns3/tf9zrX3eLQU3DA6zLDq/PGe9xcEpYnRQu0h1B2wQ==
X-Received: by 2002:a05:6a20:6a05:b0:174:c134:81fa with SMTP id p5-20020a056a206a0500b00174c13481famr37890529pzk.17.1699369999196;
        Tue, 07 Nov 2023 07:13:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p20-20020a62ab14000000b006b1ded40f36sm7276480pff.216.2023.11.07.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:13:18 -0800 (PST)
Date: Tue, 7 Nov 2023 23:13:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <carlos@maiolino.me>
Subject: Re: [Bug report][fstests generic/047] Internal error !(flags &
 XFS_DABUF_MAP_HOLE_OK) at line 2572 of file fs/xfs/libxfs/xfs_da_btree.c.
 Caller xfs_dabuf_map.constprop.0+0x26c/0x368 [xfs]
Message-ID: <20231107151314.angahkixgxsjwbot@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231029041122.bx2k7wwm7otebjd5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUiECgUWZ/8HKi3k@dread.disaster.area>
 <20231106192627.ilvijcbpmp3l3wcz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUlNroz8l5h1s1oF@dread.disaster.area>
 <20231107080522.5lowalssbmi6lus3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUnxswEfoeZQhw5P@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUnxswEfoeZQhw5P@dread.disaster.area>

On Tue, Nov 07, 2023 at 07:13:39PM +1100, Dave Chinner wrote:
> On Tue, Nov 07, 2023 at 04:05:22PM +0800, Zorro Lang wrote:
> > On Tue, Nov 07, 2023 at 07:33:50AM +1100, Dave Chinner wrote:
> > > On Tue, Nov 07, 2023 at 03:26:27AM +0800, Zorro Lang wrote:
> > > > Thanks for your reply :) I tried to do a kernel bisect long time, but
> > > > find nothing ... Then suddently, I found it's failed from a xfsprogs
> > > > change [1].
> > > > 
> > > > Although that's not the root cause of this bug (on s390x), it just
> > > > enabled "nrext64" by default, which I never tested on s390x before.
> > > > For now, we know this's an issue about this feature, and only on
> > > > s390x for now.
> > > 
> > > That's not good. Can you please determine if this is a zero-day bug
> > > with the nrext64 feature? I think it was merged in 5.19, so if you
> > > could try to reproduce it on a 5.18 and 5.19 kernels first, that
> > > would be handy.
> > 
> > Unfortunately, it's a bug be there nearly from beginning. The linux v5.19
> > can trigger this bug (with latest xfsprogs for-next branch):
> 
> Ok. Can you grab the pahole output for the xfs_dinode and
> xfs_log_dinode for s390 from both 5.18 and 5.19 kernel builds?
> (i.e. 'pahole fs/xfs/xfs_inode.o |less' and search for the two
> structures).

I can't find xfs_log_dinode in fs/xfs/xfs_inode.o, but I can find both structures
in fs/xfs/xfs_inode_item.o, so below output base on:

  # pahole fs/xfs/xfs_inode_item.o

The output on v5.19 is [1], v5.18 output is [2], the diff of 5.18 and 5.19 is [3].

Thanks,
Zorro

[1]
v5.19:
struct xfs_dinode {
        __be16                     di_magic;             /*     0     2 */
        __be16                     di_mode;              /*     2     2 */
        __u8                       di_version;           /*     4     1 */
        __u8                       di_format;            /*     5     1 */
        __be16                     di_onlink;            /*     6     2 */
        __be32                     di_uid;               /*     8     4 */
        __be32                     di_gid;               /*    12     4 */
        __be32                     di_nlink;             /*    16     4 */
        __be16                     di_projid_lo;         /*    20     2 */
        __be16                     di_projid_hi;         /*    22     2 */
        union {
                __be64             di_big_nextents;      /*    24     8 */
                __be64             di_v3_pad;            /*    24     8 */
                struct {
                        __u8       di_v2_pad[6];         /*    24     6 */
                        __be16     di_flushiter;         /*    30     2 */
                };                                       /*    24     8 */
        };                                               /*    24     8 */
        xfs_timestamp_t            di_atime;             /*    32     8 */
        xfs_timestamp_t            di_mtime;             /*    40     8 */
        xfs_timestamp_t            di_ctime;             /*    48     8 */
        __be64                     di_size;              /*    56     8 */
        __be64                     di_nblocks;           /*    64     8 */
        __be32                     di_extsize;           /*    72     4 */
        union {
                struct {
                        __be32     di_nextents;          /*    76     4 */
                        __be16     di_anextents;         /*    80     2 */
                } __attribute__((__packed__));           /*    76     6 */
                struct {
                        __be32     di_big_anextents;     /*    76     4 */
                        __be16     di_nrext64_pad;       /*    80     2 */
                } __attribute__((__packed__));           /*    76     6 */
        };                                               /*    76     6 */
        __u8                       di_forkoff;           /*    82     1 */
        __s8                       di_aformat;           /*    83     1 */
        __be32                     di_dmevmask;          /*    84     4 */
        __be16                     di_dmstate;           /*    88     2 */
        __be16                     di_flags;             /*    90     2 */
        __be32                     di_gen;               /*    92     4 */
        __be32                     di_next_unlinked;     /*    96     4 */
        __le32                     di_crc;               /*   100     4 */
        __be64                     di_changecount;       /*   104     8 */
        __be64                     di_lsn;               /*   112     8 */
        __be64                     di_flags2;            /*   120     8 */
        __be32                     di_cowextsize;        /*   128     4 */
        __u8                       di_pad2[12];          /*   132    12 */
        xfs_timestamp_t            di_crtime;            /*   144     8 */
        __be64                     di_ino;               /*   152     8 */
        uuid_t                     di_uuid;              /*   160    16 */

        /* size: 176, cachelines: 1, members: 34 */
        /* last cacheline: 176 bytes */
};

struct xfs_log_dinode {
        uint16_t                   di_magic;             /*     0     2 */
        uint16_t                   di_mode;              /*     2     2 */
        int8_t                     di_version;           /*     4     1 */
        int8_t                     di_format;            /*     5     1 */
        uint8_t                    di_pad3[2];           /*     6     2 */
        uint32_t                   di_uid;               /*     8     4 */
        uint32_t                   di_gid;               /*    12     4 */
        uint32_t                   di_nlink;             /*    16     4 */
        uint16_t                   di_projid_lo;         /*    20     2 */
        uint16_t                   di_projid_hi;         /*    22     2 */
        union {
                uint64_t           di_big_nextents;      /*    24     8 */
                uint64_t           di_v3_pad;            /*    24     8 */
                struct {
                        uint8_t    di_v2_pad[6];         /*    24     6 */
                        uint16_t   di_flushiter;         /*    30     2 */
                };                                       /*    24     8 */
        };                                               /*    24     8 */
        xfs_log_timestamp_t        di_atime;             /*    32     8 */
        xfs_log_timestamp_t        di_mtime;             /*    40     8 */
        xfs_log_timestamp_t        di_ctime;             /*    48     8 */
        xfs_fsize_t                di_size;              /*    56     8 */
        xfs_rfsblock_t             di_nblocks;           /*    64     8 */
        xfs_extlen_t               di_extsize;           /*    72     4 */
        union {
                struct {
                        uint32_t   di_nextents;          /*    76     4 */
                        uint16_t   di_anextents;         /*    80     2 */
                } __attribute__((__packed__));           /*    76     6 */
                struct {
                        uint32_t   di_big_anextents;     /*    76     4 */
                        uint16_t   di_nrext64_pad;       /*    80     2 */
                } __attribute__((__packed__));           /*    76     6 */
        };                                               /*    76     6 */
        uint8_t                    di_forkoff;           /*    82     1 */
        int8_t                     di_aformat;           /*    83     1 */
        uint32_t                   di_dmevmask;          /*    84     4 */
        uint16_t                   di_dmstate;           /*    88     2 */
        uint16_t                   di_flags;             /*    90     2 */
        uint32_t                   di_gen;               /*    92     4 */
        xfs_agino_t                di_next_unlinked;     /*    96     4 */
        uint32_t                   di_crc;               /*   100     4 */
        uint64_t                   di_changecount;       /*   104     8 */
        xfs_lsn_t                  di_lsn;               /*   112     8 */
        uint64_t                   di_flags2;            /*   120     8 */
        uint32_t                   di_cowextsize;        /*   128     4 */
        uint8_t                    di_pad2[12];          /*   132    12 */
        xfs_log_timestamp_t        di_crtime;            /*   144     8 */
        xfs_ino_t                  di_ino;               /*   152     8 */
        uuid_t                     di_uuid;              /*   160    16 */

        /* size: 176, cachelines: 1, members: 34 */
        /* last cacheline: 176 bytes */
};


[2]
v5.18:
struct xfs_dinode {
        __be16                     di_magic;             /*     0     2 */
        __be16                     di_mode;              /*     2     2 */
        __u8                       di_version;           /*     4     1 */
        __u8                       di_format;            /*     5     1 */
        __be16                     di_onlink;            /*     6     2 */
        __be32                     di_uid;               /*     8     4 */
        __be32                     di_gid;               /*    12     4 */
        __be32                     di_nlink;             /*    16     4 */
        __be16                     di_projid_lo;         /*    20     2 */
        __be16                     di_projid_hi;         /*    22     2 */
        __u8                       di_pad[6];            /*    24     6 */
        __be16                     di_flushiter;         /*    30     2 */
        xfs_timestamp_t            di_atime;             /*    32     8 */
        xfs_timestamp_t            di_mtime;             /*    40     8 */
        xfs_timestamp_t            di_ctime;             /*    48     8 */
        __be64                     di_size;              /*    56     8 */
        __be64                     di_nblocks;           /*    64     8 */
        __be32                     di_extsize;           /*    72     4 */
        __be32                     di_nextents;          /*    76     4 */
        __be16                     di_anextents;         /*    80     2 */
        __u8                       di_forkoff;           /*    82     1 */
        __s8                       di_aformat;           /*    83     1 */
        __be32                     di_dmevmask;          /*    84     4 */
        __be16                     di_dmstate;           /*    88     2 */
        __be16                     di_flags;             /*    90     2 */
        __be32                     di_gen;               /*    92     4 */
        __be32                     di_next_unlinked;     /*    96     4 */
        __le32                     di_crc;               /*   100     4 */
        __be64                     di_changecount;       /*   104     8 */
        __be64                     di_lsn;               /*   112     8 */
        __be64                     di_flags2;            /*   120     8 */
        __be32                     di_cowextsize;        /*   128     4 */
        __u8                       di_pad2[12];          /*   132    12 */
        xfs_timestamp_t            di_crtime;            /*   144     8 */
        __be64                     di_ino;               /*   152     8 */
        uuid_t                     di_uuid;              /*   160    16 */

        /* size: 176, cachelines: 1, members: 36 */
        /* last cacheline: 176 bytes */
};

struct xfs_log_dinode {
        uint16_t                   di_magic;             /*     0     2 */
        uint16_t                   di_mode;              /*     2     2 */
        int8_t                     di_version;           /*     4     1 */
        int8_t                     di_format;            /*     5     1 */
        uint8_t                    di_pad3[2];           /*     6     2 */
        uint32_t                   di_uid;               /*     8     4 */
        uint32_t                   di_gid;               /*    12     4 */
        uint32_t                   di_nlink;             /*    16     4 */
        uint16_t                   di_projid_lo;         /*    20     2 */
        uint16_t                   di_projid_hi;         /*    22     2 */
        uint8_t                    di_pad[6];            /*    24     6 */
        uint16_t                   di_flushiter;         /*    30     2 */
        xfs_log_timestamp_t        di_atime;             /*    32     8 */
        xfs_log_timestamp_t        di_mtime;             /*    40     8 */
        xfs_log_timestamp_t        di_ctime;             /*    48     8 */
        xfs_fsize_t                di_size;              /*    56     8 */
        xfs_rfsblock_t             di_nblocks;           /*    64     8 */
        xfs_extlen_t               di_extsize;           /*    72     4 */
        xfs_extnum_t               di_nextents;          /*    76     4 */
        xfs_aextnum_t              di_anextents;         /*    80     2 */
        uint8_t                    di_forkoff;           /*    82     1 */
        int8_t                     di_aformat;           /*    83     1 */
        uint32_t                   di_dmevmask;          /*    84     4 */
        uint16_t                   di_dmstate;           /*    88     2 */
        uint16_t                   di_flags;             /*    90     2 */
        uint32_t                   di_gen;               /*    92     4 */
        xfs_agino_t                di_next_unlinked;     /*    96     4 */
        uint32_t                   di_crc;               /*   100     4 */
        uint64_t                   di_changecount;       /*   104     8 */
        xfs_lsn_t                  di_lsn;               /*   112     8 */
        uint64_t                   di_flags2;            /*   120     8 */
        uint32_t                   di_cowextsize;        /*   128     4 */
        uint8_t                    di_pad2[12];          /*   132    12 */
        xfs_log_timestamp_t        di_crtime;            /*   144     8 */
        xfs_ino_t                  di_ino;               /*   152     8 */
        uuid_t                     di_uuid;              /*   160    16 */

        /* size: 176, cachelines: 1, members: 36 */
        /* last cacheline: 176 bytes */
};

[3]
# diff -Nup xfs_inode_item.pahole.518 xfs_inode_item.pahole.519
@@ -6763,16 +6799,30 @@ struct xfs_dinode {
        __be32                     di_nlink;             /*    16     4 */
        __be16                     di_projid_lo;         /*    20     2 */
        __be16                     di_projid_hi;         /*    22     2 */
-       __u8                       di_pad[6];            /*    24     6 */
-       __be16                     di_flushiter;         /*    30     2 */
+       union {
+               __be64             di_big_nextents;      /*    24     8 */
+               __be64             di_v3_pad;            /*    24     8 */
+               struct {
+                       __u8       di_v2_pad[6];         /*    24     6 */
+                       __be16     di_flushiter;         /*    30     2 */
+               };                                       /*    24     8 */
+       };                                               /*    24     8 */
        xfs_timestamp_t            di_atime;             /*    32     8 */
        xfs_timestamp_t            di_mtime;             /*    40     8 */
        xfs_timestamp_t            di_ctime;             /*    48     8 */
        __be64                     di_size;              /*    56     8 */
        __be64                     di_nblocks;           /*    64     8 */
        __be32                     di_extsize;           /*    72     4 */
-       __be32                     di_nextents;          /*    76     4 */
-       __be16                     di_anextents;         /*    80     2 */
+       union {
+               struct {
+                       __be32     di_nextents;          /*    76     4 */
+                       __be16     di_anextents;         /*    80     2 */
+               } __attribute__((__packed__));           /*    76     6 */
+               struct {
+                       __be32     di_big_anextents;     /*    76     4 */
+                       __be16     di_nrext64_pad;       /*    80     2 */
+               } __attribute__((__packed__));           /*    76     6 */
+       };                                               /*    76     6 */
        __u8                       di_forkoff;           /*    82     1 */
        __s8                       di_aformat;           /*    83     1 */
        __be32                     di_dmevmask;          /*    84     4 */
@@ -6790,7 +6840,7 @@ struct xfs_dinode {
        __be64                     di_ino;               /*   152     8 */
        uuid_t                     di_uuid;              /*   160    16 */
 
-       /* size: 176, cachelines: 1, members: 36 */
+       /* size: 176, cachelines: 1, members: 34 */
        /* last cacheline: 176 bytes */
 };
...
...
@@ -6932,16 +6992,30 @@ struct xfs_log_dinode {
        uint32_t                   di_nlink;             /*    16     4 */
        uint16_t                   di_projid_lo;         /*    20     2 */
        uint16_t                   di_projid_hi;         /*    22     2 */
-       uint8_t                    di_pad[6];            /*    24     6 */
-       uint16_t                   di_flushiter;         /*    30     2 */
+       union {
+               uint64_t           di_big_nextents;      /*    24     8 */
+               uint64_t           di_v3_pad;            /*    24     8 */
+               struct {
+                       uint8_t    di_v2_pad[6];         /*    24     6 */
+                       uint16_t   di_flushiter;         /*    30     2 */
+               };                                       /*    24     8 */
+       };                                               /*    24     8 */
        xfs_log_timestamp_t        di_atime;             /*    32     8 */
        xfs_log_timestamp_t        di_mtime;             /*    40     8 */
        xfs_log_timestamp_t        di_ctime;             /*    48     8 */
        xfs_fsize_t                di_size;              /*    56     8 */
        xfs_rfsblock_t             di_nblocks;           /*    64     8 */
        xfs_extlen_t               di_extsize;           /*    72     4 */
-       xfs_extnum_t               di_nextents;          /*    76     4 */
-       xfs_aextnum_t              di_anextents;         /*    80     2 */
+       union {
+               struct {
+                       uint32_t   di_nextents;          /*    76     4 */
+                       uint16_t   di_anextents;         /*    80     2 */
+               } __attribute__((__packed__));           /*    76     6 */
+               struct {
+                       uint32_t   di_big_anextents;     /*    76     4 */
+                       uint16_t   di_nrext64_pad;       /*    80     2 */
+               } __attribute__((__packed__));           /*    76     6 */
+       };                                               /*    76     6 */
        uint8_t                    di_forkoff;           /*    82     1 */
        int8_t                     di_aformat;           /*    83     1 */
        uint32_t                   di_dmevmask;          /*    84     4 */
@@ -6959,7 +7033,7 @@ struct xfs_log_dinode {
        xfs_ino_t                  di_ino;               /*   152     8 */
        uuid_t                     di_uuid;              /*   160    16 */
 
-       /* size: 176, cachelines: 1, members: 36 */
+       /* size: 176, cachelines: 1, members: 34 */
        /* last cacheline: 176 bytes */
 };

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

